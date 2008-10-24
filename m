From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Fri, 24 Oct 2008 09:14:26 +0200
Message-ID: <cb7bb73a0810240014o2209194dodc4a6fe3b754b04f@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
	 <alpine.DEB.1.10.0810232314490.20238@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 09:15:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtGtZ-0000P2-Oc
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYJXHO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYJXHO2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:14:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:51185 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYJXHO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 03:14:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so248994ywe.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GIEpl1wdv3B1RnC/FZNP5TVXH8CnUwmkP7OyYiB1z8c=;
        b=Zo9BxkIfqlZ1phNulgZdVv9p7JhXeni4UGzEz06l4Ez7YXISOhMhnDiCw+Tt03X/0i
         qfXwFIGwYB8mh7eK5eHgyDb/X5GZyPOqwQQIuhEHmeTNu97Ws3lGSiJ0yyxS90SXxq9d
         nJA9C65E+lOKYV2IzRN+DRjy7acAv28xTTyiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vq+NJsIhGN+qC6Sg9Rhb+B0j/eCJWm8a6DvkiPAYW7CqZQO1VkPS5XIqGm8L+M6F0s
         530eyXpdCrBUIX7JBsjdAiblyX2pUPEXz/NWXZUU13BCeY8N8LLFFW/5azmGsFUvr1wn
         HMNNNCr2IKi1xuY5tN5cx0jf98sYO0Y5rbdNg=
Received: by 10.151.108.20 with SMTP id k20mr5278304ybm.233.1224832466529;
        Fri, 24 Oct 2008 00:14:26 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 00:14:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810232314490.20238@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99015>

On Fri, Oct 24, 2008 at 8:21 AM,  <david@lang.hm> wrote:
> On Thu, 23 Oct 2008, Giuseppe Bilotta wrote:
>
>> I decided to give the simpler GIT_DIR approach another go.
>>
>> The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
>> .file.git/ to track file's history. .file.git/info/excludes is
>> initialized to the very strong '*' pattern to ensure that things such
>> as git status etc only consider the actually tracked file.
>>
>> The obvious advantage over the previous implementation is that we
>> don't rely on fragile and non-portable hardlinks. The disadvantage
>> is that something really bad can happen if a command fails to obey
>> GIT_DIR or GIT_WORK_TREE correctly.
>
> this is a very interesting approach.
>
> the thought that hit me as I finidhed reading this thread is that we are
> very close to having the full continum of file/repository combinations
>
> 1. everything in the dir is part of one repository (the normal git case)
>
> 2. some of all of the individual files in a dir is it's own repository (the
> zit case)
>
> 3. the in-between case where you can have multiple repositories that can
> have multiple files in them.
>
> how hard would it be to extend zit to support case #3?
>
> offhand I can see it complicating the task of figuring out which repository
> to use for a file, but what else?

I haven't tried this yet, but I think it should be possible without
much problems. The important thing to keep in mind is that the second
parameter to zit (for all commands but zit init) 'only' identifies the
repository, and the filename parameter is NOT passed to git. The only
exceptions are zit add and git commit, and I'm having second thoughts
on add. Anyway, you can always use the 'raw' version of a command to
guarantee that only GIT_DIR and GIT_WORK_TREE are set, thus:

$ zit rawadd somefile -f someotherfile

will force-add someotherfile to somefile's repo. (Force adding is
required because of the blanket exclude.) Of course, it would be
interesting adding to zit the capability to do

$ zit diff someotherfile

to make it guess that it should use somefile's repo. This is possible
with some symlinks for the git repos, probably.

I'll have a look into it.

-- 
Giuseppe "Oblomov" Bilotta
