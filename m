From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/6] worktree.c: retrieve lock status (and optionally
 reason) in get_worktrees()
Date: Wed, 1 Jun 2016 20:02:07 +0700
Message-ID: <CACsJy8CjeqwKWbV==wSuwH3eVghSEMFv01tTd9dCE5m14RQo1w@mail.gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com>
 <20160530104939.28407-5-pclouds@gmail.com> <xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b85nO-0001av-R8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 15:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbcFANCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 09:02:44 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38672 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbcFANCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 09:02:43 -0400
Received: by mail-it0-f54.google.com with SMTP id i127so18716386ita.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A9l8eqvNPTA4hq9+ksu8lIXykLzmXqL3Wap3j0vJEQ0=;
        b=iCt7azpdY5617vnaU7irp7xLsTgBok0D5W1YsTYTg72jUuj657vIGjjEPs4PEeg634
         3e0m8pPGCoYm3xfTf/FOZYfyXMY+d8/t3xADvRk0sBp6WxRfByUHkDi8OMLR7921W5Uq
         A5Nj/wKNzpofRiDDoyWgkicLmzNaYS5tq4o/qgj4uZgIfkLj66B04eV/Kq1IS8XlQTeY
         ueme7PBdswMvvu72/nUSzakbnrPaT7F1xbFyfBh2RQp1UZmu8WBT/DrN+mIg1behOJVe
         M4GvnTW2dKCetP2Elm3m5eEmJiptAjDtlN9bjjijbiq3cV7LKz0bTfHjacFU2HgUBVOd
         VUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A9l8eqvNPTA4hq9+ksu8lIXykLzmXqL3Wap3j0vJEQ0=;
        b=ZRcgydyjg8DSl1LY+WGHo1yubTXL8s1eJkQK5U9NHD1lYOn9v78hLITE2WSugHDrMg
         y2hCgT2iUE9+/vEy6tg3DRO/7mehgo9jTu1kJ/pOzd/urpLgO2IUQvOCduJPQivwcGKf
         XcdwRrfofig3NLzSLtNgR/9fhczfvZLVhAErWA3DMACSlCPd0w+uoeb9317Ou8n5yrDy
         A2RGDFWuFKiKK91i9egIqiaFSCuSyIQYCzBtEBCeNDY7UEFitop2MmEpJhDJn3Q2nYT+
         AIAyA/MvalEu0L7457piM9iB3iLu7YQM0CboZ2weg+sGXp/gKtWvHw9qH6TBsFfRUIJE
         OsmQ==
X-Gm-Message-State: ALyK8tK1DH7BU//18qTh9upkXcqaFk/MZrDHTJIj6bXlstx6meen+BAJ7cFrEhPbzA6LLtFEtVMnbQ3xr9n6EQ==
X-Received: by 10.36.43.23 with SMTP id h23mr21222820ita.57.1464786157560;
 Wed, 01 Jun 2016 06:02:37 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 06:02:07 -0700 (PDT)
In-Reply-To: <xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296082>

On Wed, Jun 1, 2016 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> We need this later to avoid double locking a worktree, or unlocking =
one
>> when it's not even locked.
>
> Shouldn't this be done lazily?
>
> If a user is working in worktree B and is not doing anything funky,
> she would not care why worktree A and C are locked, even though she
> might care the fact that they are locked.

You and Eric will have to settle this. It was done lazily in v2, but
Eric convinced me this lock thing will be needed for many worktree
commands (list, lock, unlock, move, remove and maybe even prune) that
it makes more sense to make it a field in struct worktree instead. For
a dozen worktrees, it does not really matter. But get_worktrees() is
also being used outside "git worktree" command, some of those new
callers may get picky. Maybe a common ground is adding a flag to
get_worktrees() to select what fields to be filled?
--=20
Duy
