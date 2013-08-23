From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after
 non-dumb push
Date: Fri, 23 Aug 2013 14:52:17 -0500
Message-ID: <CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:52:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxPD-0001mm-9j
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab3HWTwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:52:19 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:42174 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab3HWTwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:52:18 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so824369lab.16
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1YkF+gx0DUp6hOEmQPTTKgFh63se5usHF+5KLk0bz1s=;
        b=0pvLQn7zndQk3whtfJ5Q0k3h1DvFnRzxkuug7mSxxFeVIIYxsw4C8+q1z66WwVlS12
         qYmTfe1J91TgOd8zxQSCKv8xeIUfFiQ4eq4vqKhMbYn7imr1RfB8hQ+MhwD1mxPfvgj7
         0VPiLbi1yj1M/Z9PbI6iQ7IcicM0OIfSn8HejkxUhcNim744mBqk/UakVX2bBKOT1gKl
         1EwhaD7CZpqPH1GIEelMuiUbpoYrKta0ifjP+0pQjxv9kR35zYt8n6zelWPLNU8354Yr
         U2P2qvLbZ3vhxG8Cs21ssLQzusCQPbLpsvCSqGhvNHRdfH9oHstPcQyIJWNVPY5deZj6
         Vl7w==
X-Received: by 10.152.21.225 with SMTP id y1mr866355lae.18.1377287537343; Fri,
 23 Aug 2013 12:52:17 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 23 Aug 2013 12:52:17 -0700 (PDT)
In-Reply-To: <vpqbo4o3jba.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232832>

On Fri, Aug 23, 2013 at 3:25 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> This is assuming you follow the scheme
>
>   git -> local repo for other vcs -> remote repo for other vcs
>
> which itself more or less assumes that the other VCS is a decentralized
> VCS. I understand this is a good idea for hg or bzr remote helpers, but
> not applicable for git-remote-mediawiki.

A centralized repository is a subset of decentralized workflows.

> Back to my original problem: the point of dumb push is to make sure the
> next import will re-import the pushed revisions. if I use something
> other than the private namespace to keep track of the last imported,
> then I'll need to do a non-fast forward update to the private ref. I
> could do that by sending "feature force\n" it the beginning of the
> fast-import stream when importing, but that loses one safety feature
> (e.g. I detected the breakage thanks to the non-fast forward error
> message, while the tests incorrectly pass if I enable "force").

I don't know if a dumb push is the right thing to do here, but
supposing it is, you can still report non-fast-forward errors:

https://github.com/felipec/git/commit/0f7f0a223d710d29a4f1a03fc27348a8690d8a19
https://github.com/felipec/git/commit/b67a8914bc1bb3ad23591875611165b84135aaf9

If it's too much hassle to find non-fast-forward situations by
yourself, then perhaps it would make sense to update the remote
namespace only when a certain feature has been flagged.

-- 
Felipe Contreras
