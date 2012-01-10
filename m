From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: leaky cherry-pick
Date: Tue, 10 Jan 2012 08:38:30 +0700
Message-ID: <CACsJy8DpOY6UUVBjPK4k5BbvbfAckc+N5hoDTwRq5c7koZ=OgQ@mail.gmail.com>
References: <20120109223737.GA1589@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 02:39:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkQgA-0004zn-DY
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 02:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab2AJBjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 20:39:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60908 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab2AJBjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 20:39:03 -0500
Received: by bkvi17 with SMTP id i17so72269bkv.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 17:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JqtkAqCUnV6WZNx49E7Sks9stZwa8QdTBW+AvquzhVI=;
        b=m81FGg0EI98lj8g1beiK7PYMUt4Zzol/E6QOu6z6hAV0J0u9sM7hNs7ZqHf8YZjX2m
         zB5aFZgTcH3ND1YT1024gNpI/BBnQNcl1ZV3XlqIXU9yHHPwN203SWP981nnBgiMk2x2
         ANovWkT9iJDxMDb0MayUZ0asXe8ImsoFRrD/0=
Received: by 10.204.156.83 with SMTP id v19mr8262647bkw.40.1326159541213; Mon,
 09 Jan 2012 17:39:01 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Mon, 9 Jan 2012 17:38:30 -0800 (PST)
In-Reply-To: <20120109223737.GA1589@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188205>

On Tue, Jan 10, 2012 at 5:37 AM, Pete Wyckoff <pw@padd.com> wrote:
> I've got a big tree, and rebased 200 commits today using
> cherry-pick. =C2=A0It ran out of memory. =C2=A0Both 1.7.4 and recent
> master (eac2d83 (Git 1.7.9-rc0, 2012-01-06)) behave similarly.
>
> Here's a valgrind dump for rebasing just 9 commits, if someone is
> interested to track this down. =C2=A0This was invoked as:
>
> =C2=A0 =C2=A0valgrind --log-file=3D/tmp/vg.out --leak-check=3Dfull \
> =C2=A0 =C2=A0/home/pw/src/git/git cherry-pick 8d535b6^..2cf53a0
>
> I can re-test if you like, or provide more detail if this seems
> unusual.
>
> Scroll to the end to see the biggest leaks.

Index entries are leaked since probably forever because we allocated
entries in bulk and could not release them individually, until debed2a
(read-cache.c: allocate index entries individually). Putting
discard_index() to read_and_refresh_cache() might help, I think.
--=20
Duy
