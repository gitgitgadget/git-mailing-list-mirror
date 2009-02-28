From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Ensure proper setup of git_dir for git-hash-object
Date: Sat, 28 Feb 2009 14:39:51 -0700
Message-ID: <51419b2c0902281339k35f21b72v83310000b60a1416@mail.gmail.com>
References: <1235851009-16739-1-git-send-email-newren@gmail.com>
	 <7v3adyffax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 22:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWvy-0000M9-65
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZB1Vjy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 16:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbZB1Vjy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:39:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:62212 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZB1Vjx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 16:39:53 -0500
Received: by gxk22 with SMTP id 22so3751355gxk.13
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cfIXqwJBFdC4K7UttdZd+Ngazjz1E5XE1n5SlcSwTSM=;
        b=cUxEfA/2bptNyAhGPfvN1R5pD4d1Z7vEf+hQvisxAEGZNOtKAgahbHrr+s00rBRN6M
         d6CRITd+SRVr36Lc5uV26jAM3dgllFWJnK6L2Qyh75/C6BUx4LizbBC5xNiMMtGnJWMw
         r71ab6G0WEqc3ZjvMinE0WWvb33+oQ7/+AJ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jUeI6Odb9b9Y5OaFsYsRof0osIlkN01XMcJQSNprkN42ZJWjOyPt5TtcV3l5gucTVV
         3N6yzwXjYg2YGpQ7oEpn9XI1Ucrzss28hCv77PtJ18Ddb4yJAEj6Bbcp1zDqohKHWhM7
         I8H8X/plJUen0geIdfFgvWLA1jXk50099LUx8=
Received: by 10.150.156.9 with SMTP id d9mr6845533ybe.95.1235857191650; Sat, 
	28 Feb 2009 13:39:51 -0800 (PST)
In-Reply-To: <7v3adyffax.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111795>

On Sat, Feb 28, 2009 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> newren@gmail.com writes:
>
>> Without this patch:
>> $ mkdir tmp
>> $ cd tmp/
>> $ git init --bare
>> Initialized empty Git repository in /home/newren/floss-development/g=
it/tmp/
>> $ echo hi | git hash-object -w --stdin
>> error: unable to create temporary sha1 filename .git/objects/45: No =
such file or directory
>>
>> fatal: Unable to add stdin to database
>> $ echo hi | git --git-dir=3D. hash-object -w --stdin
>> 45b983be36b73c0788dc9cbcb76cbb80fc7bb057
>
> Does the patched version work without -w option? =C2=A0Should it?

Sorry, I think I partially missed what you were asking earlier.  When
-w is not passed there is no dependence on git_dir, so it does not
matter if it is set up or not.  Some evidence that this is true (in
addition to my basic testing): The call to git_config was added to
hash-object.c in revision ff350ccf49a800c4c90f817d346fb1bcb96e02e7;
prior to that revision, when -w was not passed, there would be no
setup of git_dir by either git_config or git_setup_directory.
