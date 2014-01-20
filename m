From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 05/14] read-cache: put some limits on file watching
Date: Mon, 20 Jan 2014 08:36:48 +0700
Message-ID: <CACsJy8Cpno0-z5sgZRsRz6H6Oo+V5qa4UtKqNLT+Cs3Cj420Nw@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-6-git-send-email-pclouds@gmail.com>
 <87ha8zewas.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Jan 20 02:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W53no-0007TV-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 02:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbaATBhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 20:37:20 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:45824 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbaATBhT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 20:37:19 -0500
Received: by mail-qe0-f45.google.com with SMTP id 1so243065qec.18
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 17:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mGlmpTvnbhHmF/4jqofNuuHNf6/5dKPOrDsQutGy1Xo=;
        b=o6w0bUeo22goUx5TjpFOC1iCvpnNhbiS3AnZgHFUNILLSBgblgIBFYplJ2yqbEtXfi
         yJu0RBxtF6ET4Ys3GMuYaJHOXW/feX8yR6e2dez9KrZjOVbMQPXV7JtO5cDbJVyZyYGo
         c3hG+eOY5fJgpCr0a2lp91e0okrVJadeYrMNgMIuazPH6anUGjP+YDtjKrbITSfWVkVW
         gyEPWU8U/DwFT/ucvSnBzqjAIQIt3ud1vRz3vbXkZG+KSbt9hB0C4Ihdlm9kl6KodAwZ
         mhr3AOaW2pHoIuhbt00n5BUPUUaPQiNRHTmp0uuW3pa8fd/BOBy/n7TnXjYuZT5EgvY0
         FnbA==
X-Received: by 10.229.10.197 with SMTP id q5mr20334979qcq.15.1390181838920;
 Sun, 19 Jan 2014 17:37:18 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 19 Jan 2014 17:36:48 -0800 (PST)
In-Reply-To: <87ha8zewas.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240705>

On Mon, Jan 20, 2014 at 12:06 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> watch_entries() is a lot of computation and could trigger a lot more
>> lookups in file-watcher. Normally after the first set of watches are
>> in place, we do not need to update often. Moreover if the number of
>> entries is small, the overhead of file watcher may actually slow git
>> down.
>>
>> This patch only allows to update watches if the number of watchable
>> files is over a limit (and there are new files added if this is not
>> the first time). Measurements on Core i5-2520M and Linux 3.7.6, abou=
t
>> 920 lstat() take 1ms. Somewhere between 2^16 and 2^17 lstat calls th=
at
>> it starts to take longer than 100ms. 2^16 is chosen at the minimum
>> limit to start using file watcher.
>>
>> Recently updated files are not considered watchable because they are
>> likely to be updated again soon, not worth the ping-pong game with
>> file watcher. The default limit 30min is just a random value.
>
> But then a fresh clone of a big repository would not get any benefit
> from the watcher?
>
> Not yet sure how to best handle this.

Gaahh, perhaps limit the number of unwatchable recent files to a
hundred or so in addition to time limit.
--=20
Duy
