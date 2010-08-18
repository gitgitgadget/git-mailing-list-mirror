From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Tue, 17 Aug 2010 22:41:25 -0400
Message-ID: <AANLkTi=Fkj-_-wHZN4GY2b+2n0mk7MKV=au0Hm4B+i9d@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<AANLkTi=0j_JFWBp=kJG6v+YBUxKAiVAVc4UtG0LWmipq@mail.gmail.com>
	<201008172320.17939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 04:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlYaq-00058M-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 04:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797Ab0HRCl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 22:41:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0HRCl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 22:41:27 -0400
Received: by ewy23 with SMTP id 23so59171ewy.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=KV5g1LlAJCD1C5YxgcUzWUgZBwerOO/UJNizGZaUP4Y=;
        b=JPHg3nm+hWa4/e4LMhCrRkA+XJNcpo7JPXL9AKTEVh6AoetiXzZJpDOCPSGEgWG9te
         OVAvHmbHpH7d5yJ2sYZt8N4kFdt7Ezrok7YAn81qyC1NQSSUjvArXn1BAZP0QM+G/M28
         wCIkgQPyyBXLDH/kH0jpcEIYHB6T8sdM0jjKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=s3IlN+xNfl7T3GPh8BaHgUmiBoW+B6CIV1AvkIArwy8YyGYIr345Ffp6W5HRag2k83
         hBDs8H7SrJYjRwpO8yS6Fo5hghM6I5caoh2vAdNRNxTIuma7z04i8RtWFk7ml2uPxBNf
         6naME6gF/x8iul7yn4X+h//aqnDOdveHmSfcM=
Received: by 10.213.104.211 with SMTP id q19mr6839435ebo.45.1282099285726;
 Tue, 17 Aug 2010 19:41:25 -0700 (PDT)
Received: by 10.14.47.7 with HTTP; Tue, 17 Aug 2010 19:41:25 -0700 (PDT)
In-Reply-To: <201008172320.17939.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153805>

So apparently when core.ignorecase=true, this really means
casepreserving=false, casesensitive=true. Yet when
core.ignorecase=false it actually means casepreserving=true,
casesensitive=true. That's what I infer from the git-config
documentation. Would you agree?

On Tue, Aug 17, 2010 at 5:20 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 17. August 2010, Robert Buck wrote:
>> While I tend to agree with case-insensitive searches, I would tend to
>> question the use of a non-case-preserving / last-use methodology
>> reminiscent of the days of DOS.
>
> There is no "last-use" involved. Everything's rather "first-use", i.e.,
> case-preserving.
>
>> The nice thing about case-insensitivity is that when requesting a file
>> by name any capitalization can be used. The bad thing, well come to
>> think of it, there is none that I can think of, but for those more
>> religious than I about Unix they may cite otherwise.
>
> What do you mean by "requesting a file"?
>
> core.ignorecase is purely about the worktree and the transition of files from
> the worktree to the index. It is *not* involved when files are moved from the
> index or the repository to the worktree. In particular, it is not used when
> you give a pathspec to limit 'git log' results. (Joshua proposed a change
> where core.ignorecase would also kick in in this case as well, but this
> change is not included in this series, and I would not agree to it.)

So what I am hearing is that unless one sets core.ignorecase, in mixed
environments you are in for a world of hurt; you'd end up with Foo and
foo from the Unix side of the house, and on Macs or Windows the last
file materialized from the index or repository into the working
directory would clobber the first one materialized, potentially
introducing relatively quiescent bugs that could make their way into
production environments.
