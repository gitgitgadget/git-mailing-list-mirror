From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked 
	files
Date: Wed, 11 Aug 2010 23:19:53 -0400
Message-ID: <AANLkTi=uKceZZGLDP5+9DN8yBtWwt070ftWSc3J-Y63i@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<7vmxstypot.fsf@alter.siamese.dyndns.org>
	<AANLkTinbMHDa6P8N4Mne34rMkmzzbrpm0osd2LRbr-Jv@mail.gmail.com>
	<7vaaosv8lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:20:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOKp-0007D3-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759602Ab0HLDT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:19:58 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:47758 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759131Ab0HLDT6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 23:19:58 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-30-4c6368528987
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id C9.93.02554.258636C4; Wed, 11 Aug 2010 23:19:47 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7C3JuRm005053
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 23:19:56 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7C3JsdN000844
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 23:19:55 -0400 (EDT)
Received: by wwj40 with SMTP id 40so989128wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:19:54 -0700 (PDT)
Received: by 10.216.155.206 with SMTP id j56mr9895665wek.67.1281583193989; 
	Wed, 11 Aug 2010 20:19:53 -0700 (PDT)
Received: by 10.216.19.142 with HTTP; Wed, 11 Aug 2010 20:19:53 -0700 (PDT)
In-Reply-To: <7vaaosv8lt.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhWWM9wVlxO6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153334>

> Here is the one that troubles me the most:
>
> =A0(6) git add dir/f*
>
> This _looks_ like very explicitly named from git's point of view, but=
 from
> the end user's point of view it is not. =A0Depending on presense (or =
absense)
> of another file whose name begins with 'f' in the directory, the add =
will
> be either prevented or silently accepted.
>
> I am not sure what the best solution would be; I tend to think the cu=
rrent
> behaviour is slightly saner in the face of shell globbing.
I agree that case seems rather gray.  But in what circumstances would
you expect it to be a problem?  I think only if the user has a tracked
file with local changes that he or she does not wish to be committed.
How common is it that a user will do this and expect gitignores to
protect that file's changes  I don't believe I've ever tried that in
practice, but I also wouldn't trust gitignores to protect me from
myself, as a careless 'git commit -a' would still commit my changes.

Perhaps one could add some syntax to .gitignore files that configures
this behavior.  I can come up with a proposal for something along
those lines if you believe it would be useful.  However, I don't have
great use case for it, unless we also make 'git commit -a' and friends
respect this configuration.  (As an example, perhaps a line like
+dir
would mean that file should be excluded even if the user runs 'git add
dir/file' while a line like
dir
would mean that 'git add dir/file' should succeed if dir/file is
already tracked.)
