From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Tue, 11 Feb 2014 06:34:52 +0700
Message-ID: <CACsJy8ACvd6QaqUySiZSuJmMkJiM1QWr5+jsutPKuajPY_spEg@mail.gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de>
 <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com>
 <52F7E2BC.5030905@web.de> <CACsJy8A9JxDWhEWpdUUL_6tTJZvmf93Ga_nPt09yUzG44mc-Qg@mail.gmail.com>
 <52F90483.7050206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 11 00:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD0Nv-0005LD-GE
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 00:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaBJXf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 18:35:27 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:59618 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbaBJXfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 18:35:23 -0500
Received: by mail-qa0-f51.google.com with SMTP id f11so10793865qae.10
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DORROJ71paQ2+YRCkFLKcVuu4iw/iMgDAcF8D7Gf258=;
        b=a+hxbbwzW29hO8y05CYi64neZJnzQKdFSVHGG90eaH3A90Bp5NTXmZ0Oxxu585PHuq
         sr05tYkWhPgkuEA9nprI04VTBVAgFgTV1alVuw2g8fLmN+59hJaDAXivUaGsX+DdX9sS
         EnkJfbemQ/GD5r73fVtTrI5OdIvtcNrw7qJG7GWuhJRk1G1XzgA+ZrkfCmiAYtvMOlt7
         0B9JQyArhwO78rS+7PdkFWXCInAcPfPwGmSDmBNGgiiRzYeuLfQ1+B66rsjtlZuvP2+Y
         ouUOwyhuQp1EVpiTGPl9NVyFsW3GtC3fSbgcVFjsq91gtcsjtacMbKkMwcWP7O1zOnwh
         Y5ng==
X-Received: by 10.140.40.5 with SMTP id w5mr49523772qgw.65.1392075322444; Mon,
 10 Feb 2014 15:35:22 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 10 Feb 2014 15:34:52 -0800 (PST)
In-Reply-To: <52F90483.7050206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241934>

On Mon, Feb 10, 2014 at 11:55 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2014-02-10 11.37, Duy Nguyen wrote:
>>>
>>> Could we use relative path names internally, relative to $GIT_DIR ?
>>
>> No because this is when the client tell the server about $GIT_DIR. I
>> guess we can use realpath(1) here.
> Good.
>
> I realized that the watcher can watch several repos at the same time.
>
> However, we could allow relative path names, which will be relative t=
o $SOCKET_DIR,
> and loosen the demand for an absolut path name a little bit.
> And $SOCKET_DIR can be the same as $GIT_DIR, when we are watching onl=
y one repo.

It does not help much anyway because file-watcher-lib.c sends
get_git_work_tree(), which is absolute/normalized path, to
file-watcher. There's no sources of sending $GIT_DIR relative to
$SOCKET_DIR (and I don't think we want to make get_git_work_tree()
relative before sending, it's more work on both sides we no benefits,
except for tracing).
--=20
Duy
