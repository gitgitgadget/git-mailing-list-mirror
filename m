From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory
 is changed
Date: Mon, 21 Jul 2014 15:23:59 +0100
Message-ID: <53CD227F.5070708@ramsay1.demon.co.uk>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com> <53CD1529.9080102@ramsay1.demon.co.uk> <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:24:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9EVg-0000Ch-8k
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 16:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbaGUOYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 10:24:05 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44352 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932428AbaGUOYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 10:24:04 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id D16601280A9;
	Mon, 21 Jul 2014 15:23:47 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9A4F612809B;
	Mon, 21 Jul 2014 15:23:47 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 21 Jul 2014 15:23:47 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253970>

On 21/07/14 14:47, Duy Nguyen wrote:
> On Mon, Jul 21, 2014 at 8:27 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>> +void make_locked_paths_absolute(void)
>>> +{
>>> +     struct lock_file *lk;
>>> +     for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
>>> +             if (lk->filename && !is_absolute_path(lk->filename)) =
{
>>> +                     char *to_free =3D lk->filename;
>>> +                     lk->filename =3D xstrdup(absolute_path(lk->fi=
lename));
>>> +                     free(to_free);
>>> +             }
>>> +     }
>>> +}
>>
>> I just have to ask, why are we putting relative pathnames in this
>> list to begin with? Why not use an absolute path when taking the
>> lock in all cases? (calling absolute_path() and using the result
>> to take the lock, storing it in the lock_file list, should not be
>> in the critical path, right? Not that I have measured it, of course!=
 :)
>=20
> Conservative :) I'm still scared from 044bbbc (Make git_dir a path
> relative to work_tree in setup_work_tree() - 2008-06-19). But yeah
> looking through "grep hold_" I think none of the locks is in critical
> path. absolute_path() can die() if cwd is longer than PATH_MAX (and
> doing this reduces the chances of that happening). But Ren=C3=A9 is a=
dding
> strbuf_getcwd() that can remove that PATH_MAX. So I guess we should b=
e
> fine with putting absolute_path() in hold_lock_file_...*

Hmm, yes, thank you for reminding me about 044bbbc. So, yes it could
cause a (small) performance hit and a change in behaviour (die) in
deeply nested working directories. Hmm, OK.

ATB,
Ramsay Jones
