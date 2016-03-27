From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/5] branch -d: refuse deleting a branch which is
 currently checked out
Date: Sun, 27 Mar 2016 13:52:18 -0400
Message-ID: <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
	<cover.1458927521.git.k@rhe.jp>
	<cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akErS-0007dh-5z
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbcC0RwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 13:52:20 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33522 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbcC0RwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 13:52:19 -0400
Received: by mail-vk0-f66.google.com with SMTP id a62so12149714vkh.0
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=p21XZIXbL6ic4S0bMf/WDV7Q7G/300lhdQ7k9PcS0I8=;
        b=HX0o2DhdBvAjCXS8tNfPUtQjLupio29rxL5Uvo3eZPEx4tE0XQafa7gmpo46O9lsn2
         Gsm105CucYpEIw6fRGJLvIaj8EXLd6J7umzjXs9Mdp6ry/oY53O8sKdk584Qzcw+2CqK
         1e3gNfVQXkBA2hWhqPFIOEmLu5ZPI5da0o+JhwwY3hV4kvViwJTvQ3QPjEYwbJKekiJc
         84MRBsUKV/drbTm5xo1/dLkVC8QvJcfZSUrclZe6M9r/yrWiS4BnPin9v4uTWZD/a/q0
         6CS6jFshgUEBI6W8c73g1lE6iqHOv61g+04qVTl4fD2+TT86W5OL3TkutNFUnGL4p5ug
         KTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=p21XZIXbL6ic4S0bMf/WDV7Q7G/300lhdQ7k9PcS0I8=;
        b=I0SB4k7Lv5mChKVqeCEb2o2xx7dXJCQnSwd7jM/xIU+pPh6gmqeFcfHSK/wVW5TJcj
         ceZFZaAsHfRXkUSGadp4LNNpL0uRSHgv63RrZ6IbOmvrW4eWuwnmPMYo/sWI4RXne12B
         52TI7b9AnUjIIHLO3qJNfi+sdQJhlwrteSDAJR84ubAeXEoDsJQIPHRzE6CQk7GN0IMl
         KCajPjuoZH600vVPJ4L4yA8oZg7VJQ4fPmp70ODHixmLfINW02msmJVJXBJh20T1IMrQ
         Hw/y/ckpLfFMkoiqIUgN8dteAjSzf0xzb1Gg9HIXWlTLjv3jR5xfUnyrleixczvQOhg/
         F/zQ==
X-Gm-Message-State: AD7BkJIOgfY0I7I4Lb90fToZzm9m26ovxUZaCC0qV8JooLXfWcW3j6gBeqWPPypicauoRMPnaVQ1I7jVgOPiHA==
X-Received: by 10.31.8.142 with SMTP id 136mr12591155vki.14.1459101138236;
 Sun, 27 Mar 2016 10:52:18 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 10:52:18 -0700 (PDT)
In-Reply-To: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
X-Google-Sender-Auth: ZWV2hXwslx3IEyr0FGUQraq3cE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290019>

On Fri, Mar 25, 2016 at 2:28 PM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> When a branch is checked out by current working tree, deleting the
> branch is forbidden. However when the branch is checked out only by
> other working trees, deleting is allowed.
> Use find_shared_symref() to check if the branch is in use, not just
> comparing with the current working tree's HEAD.
>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -215,16 +216,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                 int flags = 0;
>
>                 strbuf_branchname(&bname, argv[i]);
> -               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> +               free(name);
> +               name = mkpathdup(fmt, bname.buf);
> +
> +               if (kinds == FILTER_REFS_BRANCHES &&
> +                   find_shared_symref("HEAD", name)) {
>                         error(_("Cannot delete the branch '%s' "
> -                             "which you are currently on."), bname.buf);
> +                             "which is currently checked out."), bname.buf);

Would it be possible to do a better job of letting the user know what
went wrong by stating in which worktree(s) the branch is checked out?
My concern is that someone seeing this message might respond "huh? I
have 'master' checked out, so why is this telling me that 'foo' is
checked out", and not realize that 'foo' is in fact checked out in a
different worktree.
