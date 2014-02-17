From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Mon, 17 Feb 2014 19:36:55 +0700
Message-ID: <CACsJy8Ck_Bx6kYOgx+ZMcihXPW4hd38k2U7gsGvhyG-PJhz9cQ@mail.gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de>
 <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com> <52F7E2BC.5030905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 17 13:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFNS0-00080M-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 13:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbaBQMh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 07:37:28 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:51270 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaBQMh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Feb 2014 07:37:27 -0500
Received: by mail-qa0-f41.google.com with SMTP id w8so21994294qac.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=v05HAZZ/Rlt1BGOPItRxpton+28ydHG/krzvrLec9bk=;
        b=YK+rjRGyqlOKxNw59jQ277CueCi57epnK0XuMmPGfeA68DcMP6klP5TNMxG54Le3O2
         2cZYPkbM98C0u2HVtao5vxIt2MMt2c3I4GpNq/4W4dmoCZchQ68eNLDSQB9nEL/tcKNZ
         KNR5FLXfu6iZQpVN2EP+hq7wEP7N+WDMl5ectTw7W5XNFKoWI9WJJr37QEIGIvpUugGf
         /q3ULpQPFiqTFe+WW+ubJZMaJc/QcLgB/YJ7VoOqIPRZNy5Vz/UHzi8zs55wc299Khla
         8Su0H/yVaGVeMo6DbL2GBfSBUnEO8bN1gu7d+89WnibNkshIfMQJ/mi88bDYyJcabI0O
         xXsA==
X-Received: by 10.224.167.84 with SMTP id p20mr34488296qay.24.1392640645581;
 Mon, 17 Feb 2014 04:37:25 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 17 Feb 2014 04:36:55 -0800 (PST)
In-Reply-To: <52F7E2BC.5030905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242259>

On Mon, Feb 10, 2014 at 3:19 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
>
> On 2014-02-08 09.53, Duy Nguyen wrote:
>>>> file-watcher.c | 32 ++++++++++++++++++++++++++++++++
>>>> 1 file changed, 32 insertions(+)
>>>
>>> I feel a little bit unsure about the 700.
>>> Most often Git does not care about permissions,
>>> and relies on umask being set appropriatly.
>>> (Please correct me if I'm wrong)
>>
>>Git does care. See credential-cache--daemon.c. In fact this function
>>is a copy of check_socket_directory() from that file.
>>
> I was probably a little bit unclear.
> Of course credentials should be protected well and stored with 700.
> The rest of the repo could be more loose by using adjust_shared_perm(=
).
> Because the whole repo can be shared (or not) and data is visible
> to the group or everyone.
> (this is a minor issue)

So how about a check whenever a worktree is connected to the daemon,
if that worktree has stricter permission, e.g. 0700 vs 0770 of the
daemon socket directory, then the daemon refuses the worktree (maybe
with a warning)?
--=20
Duy
