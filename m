From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] builtin-branch: use strbuf in rename_branch()
Date: Wed, 19 Nov 2008 20:48:48 +0100
Message-ID: <8c5c35580811191148m45cdff68vbe190ef911066da8@mail.gmail.com>
References: <cover.1226954771.git.vmiklos@frugalware.org>
	 <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org>
	 <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org>
	 <225d83c1ead50340eed97c64fbb8995017bf1ca8.1226954771.git.vmiklos@frugalware.org>
	 <7vbpwcvb8i.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811190209470.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 20:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2t3t-0001j6-Jl
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 20:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbYKSTsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 14:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYKSTsv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 14:48:51 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:55918 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYKSTsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 14:48:50 -0500
Received: by wf-out-1314.google.com with SMTP id 27so99224wfd.4
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kjOna3pqTzRD9DO4OUvithLOkv51xStWapYt2llHC6s=;
        b=rzJW6VKGyvS8onW0TmbsQ3k+OlqsCmzfCGZC5n5DUkk/McUF5uN5ybflc7/UvAGOGj
         oFm4Vcpy/d1WQZ+rELCjnjVr6R29Uv7XXPBhRZcQuOYHSlwNZ4zVe/HeXK+MMJk6Dv+m
         aLoKvZnNS/KFCA14ysiydROE/6PIEq+rQvrCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B2Y3Myd80pPj11DHQmXv+ExmPE7WCW5FhehllLkmKoC9d4dohsPFPXsLMdggKxEBxi
         kjxgiA6b7wP0TDUZ3177aYccEJDRSezG3Ebbely2er18VeaY30iPMWdbXSExyUhJsLaz
         zLA6uiwygOkRX2DFDqBhk4py1/qSbRLM/G4ZU=
Received: by 10.114.12.9 with SMTP id 9mr831955wal.216.1227124128325;
        Wed, 19 Nov 2008 11:48:48 -0800 (PST)
Received: by 10.114.196.11 with HTTP; Wed, 19 Nov 2008 11:48:48 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811190209470.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101372>

On Wed, Nov 19, 2008 at 02:11, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 18 Nov 2008, Junio C Hamano wrote:
>
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>>
>> > -   snprintf(logmsg, sizeof(logmsg), "Branch: renamed %s to %s",
>> > -            oldref, newref);
>> > +   strbuf_addf(&logmsg, "Branch: renamed %s to %s",
>> > +            oldref.buf, newref.buf);
>>
>> I am wondering why nobody has complained until now, but shouldn't this
>> be oldname and newname?
>
> I think that was the intention.  Lars?

Some background: the message was first generated internally (in
c976d415) by refs.c:rename_ref() and thus it made sense to use the
full refname. Sometime later (in 678d0f4c), rename_ref() was modified
to get the message as an argument from
builtin_branch.c:rename_branch() but the format of the message was
kept (almost) identical.

Personally, I think it's nice if the reflog contains the full refname.

--
larsh
