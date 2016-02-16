From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] dir.c: fix match_pathname()
Date: Tue, 16 Feb 2016 08:17:22 +0700
Message-ID: <CACsJy8Be+39RLr27_1kSH4WhkoVUr0SZVvCqjzZVvUTtDoAXZg@mail.gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
 <1455527019-7787-2-git-send-email-pclouds@gmail.com> <xmqqmvr1o8lk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUH7-00081k-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbcBPBRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 20:17:54 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36719 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcBPBRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 20:17:53 -0500
Received: by mail-lf0-f48.google.com with SMTP id 78so98973068lfy.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 17:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DYCfhacjeWfi4IiQQPqLAGFo5fzxvBvPCZpO48aext8=;
        b=rdOl2Xw81mcxsjbf74xGrfs/pzfZ1+BlhMjNRIKy3/DYldBAK6B/yo7e8GNQQJplhE
         +tOTkcKaG6ZNO4MHUWYrO2zHkAQYmUkyX6fENi9wZ9V0PKKKOF+Vspue63LfmVAOEtNQ
         8uTprHm7NcvMXdRIG986c6oL885CpeXz4Dtm6ZEqX+COmyS2eqESU+FA/+yJoArFJQUO
         p7BuRgUDjTs5hDGKhIL3ULWJKuWGFXyFi+Ra46k+DU9mUUUz/WzffBVRl30KrYzcJ4Gg
         xRbuBnv+H3SOe5bTjCbaKfF/F6VQb8vizwnlkBbNzTlSxOwq98pPSx6vfQtNPw6ovobL
         80cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=DYCfhacjeWfi4IiQQPqLAGFo5fzxvBvPCZpO48aext8=;
        b=WaERSELQGTMjY6S1wY6T9eTdCaQbHjYQoJnVAGoJJYQFVBRLMtyCrbJkrfmS0uHnTJ
         vDjomZKIU0rZjEDP0mUbdTOooHb9mcMMQejBzPWJZ8wE8sqtwgZgNeqzFl2dngLl3Ww1
         ac1C9cFwBSUU6mGLSDURyA5EKznDLyvdkl735maAARLrHdgkDYZXNQ41LPAhrVtshdvz
         Oa8UCsotx+tQuk29TCHIXvuFmmonedYVwRf7wWxKSAY2YiXcyEVCtr9ZBTsDD/xnn+VY
         wP91mTxlgooxXgmP49sD7YzWvfAsTJwf+H/I+FVm76LTcAYM9p3b5VfwxYeSO0yKEckU
         DvOQ==
X-Gm-Message-State: AG10YOR9S1BfS3MjqI7pam8fck94eNLy2c+55uUyQi6+2ITYZdLdm3LIQ2BOHKRN4wns3R7MKLFghBxY6MUfbQ==
X-Received: by 10.25.159.68 with SMTP id i65mr8107873lfe.94.1455585472149;
 Mon, 15 Feb 2016 17:17:52 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 15 Feb 2016 17:17:22 -0800 (PST)
In-Reply-To: <xmqqmvr1o8lk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286300>

On Tue, Feb 16, 2016 at 6:29 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Given the pattern "1/2/3/4" and the path "1/2/3/4/f", the pattern
>> prefix is "1/2/3/4". We will compare and remove the prefix from both
>> pattern and path and come to this code
>>
>>       /*
>>        * If the whole pattern did not have a wildcard,
>>        * then our prefix match is all we need; we
>>        * do not need to call fnmatch at all.
>>        */
>>       if (!patternlen && !namelen)
>>               return 1;
>>
>> where patternlen is zero (full pattern consumed) and the remaining
>> path in "name" is "/f". We fail to realize it's matched in this case
>> and fall back to fnmatch(), which also fails to catch it. Fix it.
>
> OK.  And by checking *name against '/', we won't mistakenly say that
> "1/2/3/4f" matches the pattern.  Nicely explained.
>
> Can a pattern end with a '/'?

No. At this point, we must have stripped that trailing slash and
turned it to flag EXC_FLAG_MUSTBEDIR.
--=20
Duy
