From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 3/4] Convert git_id() to the new id format
Date: Sun, 13 Jul 2008 12:20:25 +0100
Message-ID: <b0943d9e0807130420v37e36f30sef8b7745fa55b688@mail.gmail.com>
References: <20080619214023.27794.97039.stgit@localhost.localdomain>
	 <20080619214222.27794.74083.stgit@localhost.localdomain>
	 <20080622154854.GC4468@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 13:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzdy-0001A1-LR
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYGMLU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 07:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYGMLU1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:20:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:56392 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYGMLU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 07:20:26 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2645236waf.23
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=397hrarMU6SSO0z+A0DyTP9sKwWfQ2dLzE+4NYSjgDc=;
        b=SBqsAJxWBJO7m9eCfm3tMn1skbcQLaXzLB8NAvgYgw9JkMEzoUuMQwt/Rp3vXuyuS+
         OLagH3lXtosWIaDNSNykX9HGr1POukF09FzSD2L2XtWC8OE5kyLSko8j84921qkEnzLd
         nMzduKS3tYuimAWSrUF4Wa08roVfV9VGbJLkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MkZPo06/TTTxO8zsNlxp+/3rwclyH6Wlz74ccwtbO7EoYMTqyRrVCMi8HT5SGtMuad
         KFueUZP8LftzLcGWFkkKZAiJF7Nw/75sXsyLE8QLEn4loXzPr4G+vlDgDOdjDyZiyOmD
         CMvlyuB9CLYt2VTtsZ7WYY1iI3rAGwfjUAovE=
Received: by 10.114.183.20 with SMTP id g20mr16360491waf.77.1215948025096;
        Sun, 13 Jul 2008 04:20:25 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 13 Jul 2008 04:20:25 -0700 (PDT)
In-Reply-To: <20080622154854.GC4468@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88297>

2008/6/22 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-19 22:42:22 +0100, Catalin Marinas wrote:
>
>> The patch rewrites git_id() to use the new id format and coverts the
>> commands using this function. The git_id() will be removed once all
>> the commands are converted to the new infrastructure where
>> git_commit() will be used instead.
[...[
>>      if not rev:
>> +        # backwards compatibility
>>          return None
>
> Could you expand this comment a bit? It's not enough of a clue for me=
=2E
> :-/

I removed it, the diff command used to pass None as rev2 if the user
only passed one boundary of the range. I fixed diff and removed the
above.

>> -def git_commit(name, repository, branch =3D None):
>> +def git_commit(name, repository, branch_name =3D None):
>
> Very nice parameter rename here, now that we have Branch objects (and
> use a crappy language with no type system).

It has a type system but no compile-time checking (I'm more in favour
of static typing but no time to rewrite stgit :-)).

>> -        (refpatchname, refbranchname, refpatchid) =3D parse_rev(pat=
chname)
>> -        if refpatchname and not refpatchid and \
>> -               (not refpatchid or refpatchid =3D=3D 'top'):
>> -            # FIXME: should also support picking //top.old
>> +        refbranchname, refpatchname =3D parse_rev(patchname)
>> +        if refpatchname:
>
> The corresponding TODO comment now would be that pick should be able
> to pick patches from the past, from the stack log.

How would the syntax look like?

--=20
Catalin
