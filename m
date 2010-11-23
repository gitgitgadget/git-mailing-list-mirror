From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 6/6] win32: use our own dirent.h
Date: Tue, 23 Nov 2010 18:51:42 +0100
Message-ID: <AANLkTinvtdwP_C1PcFkOXfFEHfOAj3dPAfa1xyUrttEu@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-7-git-send-email-kusmabite@gmail.com> <20101123174519.GE12113@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:52:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKx2J-0007sW-0u
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab0KWRwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 12:52:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037Ab0KWRwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 12:52:03 -0500
Received: by fxm13 with SMTP id 13so4110573fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=heHb6cFGoaTjddrElf+M4D14q8FyhrBvG2dKibOu5w0=;
        b=DVG2+ReizZ+mNcudNZgnEK0w9oml2bh0DLgHuGFSF0gpJ8tlp3ZURBfe8n12euw0WO
         5nOvk58c+HlNYla+TXa05hZQlGv+7Q+sgh4ADxuTsUWwl4CDEIQuaMeF1Y6x3hPFENRm
         157tjpu9X6TrcAgbcbG5V4NZmJxS+fwRyVw70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=dyp5P1jMs6en7hHfkFhuYEZbQhmizfSvo9/JaR5kfexVqd3OFr/9SejflWmzyuOsM/
         XgJ8eSOV0sY3QOQfD17/xAVKj+kN7mgUPdkyN57JwmObkohO+gRD9YIByXgMReID68wA
         jkRWNhyoTf7WlSYvv0Kc/NTYBNJNK4Li2O9vg=
Received: by 10.223.120.84 with SMTP id c20mr249189far.102.1290534722539; Tue,
 23 Nov 2010 09:52:02 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 09:51:42 -0800 (PST)
In-Reply-To: <20101123174519.GE12113@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161998>

On Tue, Nov 23, 2010 at 6:45 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> This provides a generic Win32-implementation of opendir, readdir
>> and closedir which works on both MinGW and MSVC and does not reset
>> errno, and as a result git clone is working again on Windows.
>
> Nice! =A0Thanks.
>
>> =A0Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
7 ++-
>> =A0compat/mingw.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 60 ------=
------------
>> =A0compat/mingw.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 29 ------=
---
>> =A0compat/msvc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 49 ------=
---------
>> =A0compat/vcbuild/include/dirent.h | =A0128 ------------------------=
---------------
>> =A0compat/win32/dirent.c =A0 =A0 =A0 =A0 =A0 | =A0105 ++++++++++++++=
++++++++++++++++++
>> =A0compat/win32/dirent.h =A0 =A0 =A0 =A0 =A0 | =A0 24 +++++++
>> =A07 files changed, 134 insertions(+), 268 deletions(-)
>> =A0delete mode 100644 compat/vcbuild/include/dirent.h
>> =A0create mode 100644 compat/win32/dirent.c
>> =A0create mode 100644 compat/win32/dirent.h
>
> Does this diff get smaller with -M -C -C -C?
>

Nope. I guess the reason is that I've adjusted the code a bit while
moving it, because I didn't need to cast back and forth between HANDLE
anymore.
