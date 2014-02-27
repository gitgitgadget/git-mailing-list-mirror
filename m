From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Thu, 27 Feb 2014 10:03:15 +0700
Message-ID: <CACsJy8ChMq7cW-H4oSCi8QdMjb2Juqi=Y4k_+5395qA51RxN0g@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-11-git-send-email-pclouds@gmail.com> <xmqqzjld1l59.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 04:03:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIrGJ-0005pv-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 04:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbaB0DDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 22:03:46 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:58551 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbaB0DDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 22:03:46 -0500
Received: by mail-qc0-f179.google.com with SMTP id r5so2583837qcx.38
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 19:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BtnqYh+d2Sp0yMTPOIg7sETGhFarwPdVm3oBjoRttQM=;
        b=VjdJPLs6b9tCBVbvgzWvjkAQVP/IhbMU1IYk/k1vmt8pl8FxXqyEh7Ns6IsO1omoh2
         1puAjnKo3Hsu820+YFex1xLgSSiH/qeue29J7ItzuMUcOS7G0TAgFTuOJCTuZ8X+3fsr
         MZAtiFHmFyaDjlxrPZZ6qBYgADa/uFEj7UvrlFZyu6KJev+kfvb3zOq8nwxtUvvnzbib
         e7e9OPor6JEyBaSwYT8aimqFWZfEntomwoENbrO5z+Z+7TQg7OHuKMKrRIah2JP2Dwsg
         QG8ugcKbrviDwWtE602JrfX88APfHLa8ZTzGKF2z3iwzKcC8UmCrjuVDWi3spaKvvMvo
         Dklw==
X-Received: by 10.140.47.212 with SMTP id m78mr3905892qga.21.1393470225524;
 Wed, 26 Feb 2014 19:03:45 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 19:03:15 -0800 (PST)
In-Reply-To: <xmqqzjld1l59.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242783>

On Thu, Feb 27, 2014 at 6:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Note that logs/refs/.tmp-renamed-log is used to prepare new reflog
>> entry and it's supposed to be on the same filesystem as the target
>> reflog file. This is not guaranteed true for logs/HEAD when it's
>> mapped to repos/xx/logs/HEAD because the user can put "repos"
>> directory on different filesystem. Don't mess with .git unless you
>> know what you're doing.
>
> Hmph.  I am puzzled.
>
> We use TMP_RENAMED_LOG in rename_ref() in this sequence:
>
>  * First move refs/logs/$oldname to TMP_RENAMED_LOG;
>  * Delete refs/$oldname;
>  * Delete refs/$newname if exists;
>  * Move TMP_RENAMED_LOG to refs/logs/$newname;
>  * Create refs/$newname.
>
> in rename_ref(), and TMP_RENAMED_LOG or the helper function
> rename_tmp_log() that does the actual rename do not seem to be
> called by any other codepath.
>
> How would logs/HEAD get in the picture?  Specifically, I am not sure
> if we ever allow renaming the HEAD (which typically is a symref but
> could be detached) via rename_ref() at all.

HEAD is an exception, I agree. If you rename HEAD to something else,
the repo will not be recognized anymore because HEAD is part of the
repo signature. There are other refs outside refs/ though that can be
renamed in theory.  In practice all rename_ref() callers only operate
on refs/ domain so this is a false alarm.
--=20
Duy
