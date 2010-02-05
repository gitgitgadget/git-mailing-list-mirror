From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 5 Feb 2010 01:44:49 +0100
Message-ID: <201002050144.50538.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <7v4olxhrti.fsf@alter.siamese.dyndns.org> <201002041821.22864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:41:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCGj-00006z-3J
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 01:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319Ab0BEAlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 19:41:44 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37021 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab0BEAll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 19:41:41 -0500
Received: by fxm20 with SMTP id 20so3286384fxm.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VoWh1PzLtMUiZJHMMpycioFrgnDB1n75n6tbS4OSkgc=;
        b=ZZ6iEPjmI7Ab30puoNZbJoggssyCKDKilEL9dp643v2FjVHD/VsqveRqoyZDpgHorp
         SUueXYu5qAyvEOO1e10YwCronIR5aWYoHOXc1KeCjvetfPzVQO9xtVMwYpoVRtH82V4H
         zA4Q/kyJX8KW1mUWpJZ7FyKmHn6L6TyCx09C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sIAmvuTACR1Tj3nFmQJQ29Ujz8u+lHW/HfY3EPTIkNa/ir2gH8m/guxT6V08J94gzu
         ccnotUMUuj0x7Rj/ygMgQN6vzS6TSBkwHwZm+H7ApLSjH4ldMFcpJVYZK/+KOMX5X0UX
         TwRewI/kVYc6MXAfHks4D/HPgtLYGBBsEDUQQ=
Received: by 10.87.63.8 with SMTP id q8mr839624fgk.3.1265330499916;
        Thu, 04 Feb 2010 16:41:39 -0800 (PST)
Received: from ?192.168.1.13? (abrz208.neoplus.adsl.tpnet.pl [83.8.119.208])
        by mx.google.com with ESMTPS id 13sm359003fxm.13.2010.02.04.16.41.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 16:41:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201002041821.22864.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139015>

Jakub Narebski wrote:
> On Thu, 4 Feb 2010, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>>
>>>> +		my %notes = () ;
>>>> +		foreach my $note_ref (@note_refs) {
>>>> +			my $obj = "$note_ref:$co{'id'}";
[...]
 
> Second, parse_commit / parse_commits use
> 
>   git rev-list -z --parents --header --max-count-X
> 
> If this command automatically shows notes (or it can be modified to
> automatically show notes) after unindented "Notes:" line (as per
> git-notes documentation), then the only thing that needs to be
> changed to fill %commit{'notes'} is parse_commit_text subroutine.

This command automatically shows notes, even in absence of GIT_NOTES_REF
environment variable or core.notesRef (if core.notesRef is not unset),
so unless we want gitweb to display notes flattened into commit message
(which I think was intended behavior - design decision for notes 
display), we would need to modify parse_commit_text to gather notes 
into %commin{'notes'} (or something).

 
> There would be no need for extra subroutine (and extra command, or
> even up to two extra commands per note) to get notes data.

You are right that we would need it if we want to display notes from
non-default namespace.

Still, 1 or 2 git commands per commit is a bit too much (with shortlog
displaying 100 commits per page): that is what "git cat-file --batch"
was invented ;-)

-- 
Jakub Narebski
Poland
