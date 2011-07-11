From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Mon, 11 Jul 2011 09:56:52 -0700
Message-ID: <7vbox0g3hn.fsf@alter.siamese.dyndns.org>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com>
 <alpine.DEB.1.00.1107091935210.1985@bonsai2> <4E1A0FCC.7080308@kdbg.org>
 <alpine.DEB.1.00.1107110057120.3379@bonsai2>
 <86k4bpporf.fsf@red.stonehenge.com>
 <alpine.DEB.1.00.1107111121390.3379@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Sixt <j6t@kdbg.org>, Pat Thoyts <patthoyts@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 11 18:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJn3-0000rw-IW
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181Ab1GKQ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:56:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096Ab1GKQ4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:56:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06967676D;
	Mon, 11 Jul 2011 12:56:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGsqixguBA0egvt+mBFK7+qCaVg=; b=hWx2H/
	GsAbip1N1uCDXUxG1HnVnCmWOX1ZesC4wMfriCrQ74DoTNA1EMhzuQVVSbaiP5DU
	vsUYU3++PVsEFltDt1DoI+nhil2oAgUn4MiiM++BtZQ1jlXN3MOa0AMlskHD3PYZ
	iG3E2LiVsf9AdxjxbjH5NcyNEd3/fQCYV35pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NN2lOmJlKlMLDX9A13+DBzZxMII1DyPn
	KEGPpPU1K4k6s7eVkxzklUYgRl9i9UQykYRKGeL99SU2clmaGcMH1RPoPZgAB2ZP
	zcWsOj/bLhzi6JnZENy64eYSvv3GBQEnAxtMOFBGzuWKyyprcEj4rb9TvOoP66Ss
	vtEx/IMkUTc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F324D676C;
	Mon, 11 Jul 2011 12:56:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3455E676B; Mon, 11 Jul 2011
 12:56:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1107111121390.3379@bonsai2> (Johannes
 Schindelin's message of "Mon, 11 Jul 2011 11:26:34 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7B1A2F4-ABDE-11E0-BED4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176871>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 10 Jul 2011, Randal L. Schwartz wrote:
> ...
>> If you ever depend on a userspace PWD to be your actual current 
>> directory without at least stat()ing it, you've failed.
>> 
>> In my experience, it is *never* reliable.  It's just a hint.
>
> To be precise, get_pwd_cwd() _does_ stat() what's in PWD, and _does_ 
> compare with the stat() of what comes out of getcwd(), but that comparison 
> uses only st_dev and st_ino, both of which happen to be 0 in my case -- 
> for each and every file/directory.
>
> I can only _guess_ at the reasoning behind get_pwd_cwd(). I _think_ it was 
> meant to catch the case when getcwd() and PWD refer to the same directory, 
> but PWD goes through symbolic links.

Thanks for a much clearer explanation than before. I tried to reword the
proposed commit log message using the description above.

I feel that the title is still not optimal. If the original code used to
return getenv("PWD") if the environment variable is set, and otherwise
fell back to getcwd(), and the updated code tries to make sure they refer
to the same directory, then "Do not trust PWD blindly" would be a good
description for the fix, but the code you fixed the bug in tried not to
trust PWD blindly but failed to realize that on some systems dev/ino field
may be unreliable.

"Do not trust st.st_ino/st.st_dev blindly" might be a better title in that
sense.

In any case, thanks for a fix; will queue.

Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Sat Jul 9 19:38:08 2011 +0200

    Do not trust PWD blindly
    
    10c4c88 (Allow add_path() to add non-existent directories to the path,
    2008-07-21) introduced get_pwd_cwd() function in order to favor $PWD when
    getenv("PWD") and getcwd() refer to the same directory but are different
    strings (e.g. the former gives a nicer looking name via a symbolic link to
    an uglier looking automounted path). The function tried to determine if
    two directories are the same by running stat(2) on both and comparing
    ino/dev fields.
    
    Unfortunately, stat() does not fill any ino or dev fields in msysgit.  But
    there is a telltale: both ino and dev are 0 when they are not filled
    correctly, so let's be extra cautious.
    
    This happens to fix a bug in "get-receive-pack working_directory/" when
    the GIT_DIR would not be set correctly due to absolute_path(".")
    returning the wrong value.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Acked-by: Johannes Sixt <j6t@kdbg.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
