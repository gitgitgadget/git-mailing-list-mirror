From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 05:46:10 +0700
Message-ID: <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com> <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 23:53:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtXx-0007Cc-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbaBRWxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:53:45 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61083 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbaBRWxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:53:43 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so23980404qab.37
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OpwXpIDum7yYaf/jopoA2quGOtbi1tDfeQ56YnQI7zY=;
        b=qBPxZrevvL1lxKD3PIFKC5C+AIHwVN1WXhzGasr+Tdq5DoTsV4RKMzmxtm8Egh4deU
         zuMDYtgTgJDbxaidt+GPL+0d55DIYUudilbvd38Kq7dyr4XV5761EJm7ls9wTwgruPzG
         srsvXIv+QNr6DmFoA5l+bV82MAnyntTe+VByyLmhsFvwavCQLEt/Z6Qb8pj7UAelAcCs
         IMtEvrIRFbjn90C+9qO8bYZM13sVw7qt5HDDRg4gCcEHYq1PuwTJULx9PozWjNcEaGCU
         ObFcOQ+y4i2MB6ZRaPQJCUfLd2F+BBsBePg9OQ7eABot0QebNABGOPauh2VtT9H9zafd
         gqJQ==
X-Received: by 10.229.241.9 with SMTP id lc9mr5622985qcb.15.1392763600157;
 Tue, 18 Feb 2014 14:46:40 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 18 Feb 2014 14:46:10 -0800 (PST)
In-Reply-To: <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242365>

On Wed, Feb 19, 2014 at 3:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Let's do something like this first and then later make --depth
> configurable just like --width, perhaps?  For "aggressive", I think
> the default width (hardcoded to 250 but configurable) is a bit too
> narrow.
>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6be6c8d..0d010f0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -204,7 +204,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>
>         if (aggressive) {
>                 argv_array_push(&repack, "-f");
> -               argv_array_push(&repack, "--depth=250");
> +               argv_array_push(&repack, "--depth=20");
>                 if (aggressive_window > 0)
>                         argv_array_pushf(&repack, "--window=%d", aggressive_window);
>         }

Lower depth than default (50) does not sound "aggressive" to me, at
least from disk space utilization. I agree it should be configurable
though.
-- 
Duy
