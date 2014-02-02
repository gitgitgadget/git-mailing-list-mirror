From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 2 Feb 2014 13:09:43 +0100
Message-ID: <20140202120943.GA27787@mule>
References: <20140131202142.GA9731@mule>
 <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
 <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
 <20140202111330.GB14729@mule>
 <871tzl2209.fsf@fencepost.gnu.org>
 <52EE2DEC.4030400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com, richih@debian.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vsQ-0001b0-Os
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbaBBMJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 07:09:49 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64299 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaBBMJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:09:48 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so4544881lbv.6
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aYy8EMcebDGzXaHqDHBk21xFOKNTKEj3iuM0y+g62no=;
        b=0wjijfKKnF+mYdmMkhYO72r9WhoCjgY5e0EV7UH1NA4Q2Zmce95pePn4ngbX52JjiH
         XShisdNekUlpiCcXNymEb+oKcbmdKxUdQAWXEpL6NbexMe/c0r3ULYIM2nKN3Gv5Eiw4
         JV9RH2FX3jp1mhs8IzPXg6922H9/41YMZ5f4BNkYNFJ4D7iODgJuR+LuRE2yLEph1jNr
         w4HBSYOi2TZeVCmWIDueQhxII4jike+hyprK/xAF9MxS58iUNE7nTp8RBYnWsVezJ9jQ
         hHKLQ+mdhWFZD6pri9pUOqWXt/IMmCSBYstvtLOBscgbJhceLIiqbNTDYPFokCGkw+UE
         cuAw==
X-Received: by 10.152.43.47 with SMTP id t15mr843404lal.38.1391342986956;
        Sun, 02 Feb 2014 04:09:46 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id dm8sm24287106lad.7.2014.02.02.04.09.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 04:09:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52EE2DEC.4030400@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241367>

On Sun, Feb 02, 2014 at 12:37:16PM +0100, Torsten B=F6gershausen wrote:
> On 2014-02-02 12.21, David Kastrup wrote:
> > Martin Erik Werner <martinerikwerner@gmail.com> writes:
> >=20
> >> On Sun, Feb 02, 2014 at 09:19:04AM +0700, Duy Nguyen wrote:
> >>> On Sun, Feb 2, 2014 at 8:59 AM, Martin Erik Werner
> >>> <martinerikwerner@gmail.com> wrote:
> >>>> +       /* check if work tree is already the prefix */
> >>>> +       if (strncmp(path, work_tree, wtlen) =3D=3D 0) {
> >>>> +               if (path[wtlen] =3D=3D '/')
> >>>> +                       memmove(path, path + wtlen + 1, len - wt=
len);
> >>>> +               else
> >>>> +                       /* work tree is the root, or the whole p=
ath */
> >>>> +                       memmove(path, path + wtlen, len - wtlen =
+ 1);
> >>>> +               return 0;
> >>>> +       }
> >>>
> >>> No the 4th time is not the charm yet :) if path is "/abc/defghi" =
and
> >>> work_tree is "/abc/def" you don't want to return "ghi" as the pre=
fix
> >>> here.
> >>
> >> Ah indeed, this should catch that:
> >>
> >> diff --git a/setup.c b/setup.c
> >> index 2270bd4..5817875 100644
> >> --- a/setup.c
> >> +++ b/setup.c
> >> @@ -32,9 +32,11 @@ static inline int abspath_part_inside_repo(char=
 *path)
> >>  	if (strncmp(path, work_tree, wtlen) =3D=3D 0) {
> >>  		if (path[wtlen] =3D=3D '/')
> >>  			memmove(path, path + wtlen + 1, len - wtlen);
> >> -		else
> >> +		else if (path[wtlen - 1] =3D=3D '/' || path[wtlen] =3D=3D '\0')
> >=20
> > Is wtlen guaranteed to be nonzero?

Hmm, am I incorrect in thinking
if (!work_tree)
takes care of that?

> Another comment:
> The "raw" comparison with '/' is probably working well on all
> POSIX/Linux/Unix systems.
>=20
> To be more portable, the macro
> is_dir_sep()
> can be used:
>=20
> if (is_dir_sep(path[wtlen]))

Since the path is already normalized by 'normalize_path_copy_len' which
seems to guarantee '/'-separation, I have assumed that this was
unnecessary?

--
Martin Erik Werner <martinerikwerner@gmail.com>
