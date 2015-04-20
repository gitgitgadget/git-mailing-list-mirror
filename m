From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: What happen if show_http_message fails to reencode?
Date: Mon, 20 Apr 2015 15:29:41 +0900
Message-ID: <CAFT+Tg9x3QfS4c93Bs_Oq0zc7bXvZdFZQAKJFPtqbp6M=Q-P0g@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 08:29:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk5DH-0002ft-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 08:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbDTG3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 02:29:43 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36521 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbDTG3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 02:29:42 -0400
Received: by qgeb100 with SMTP id b100so48127332qge.3
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=/Xwhuktc7sYFFaSxlH7f5u/lAXwvA7MTtFo/35x06hY=;
        b=xW+sE5bfL7NEc7s+D4w77S4OrZ3MyTgbMXcs7r9PC2DGlYgyyI2pNMh6A3RRRvqj9F
         4ma8hPuht9Lr/RxJOknvwF/zHiu60dPufWKpFKwY4MCQXxNhwdLW5dm5xJjwPMiZxVzP
         46/9/U9+FozH3RIrSJDeG87x8+dbka7XTu/B4OdKlVq1jN1M27Kh9WDFEZnYUElvdiSX
         K6vuk+nuRY5Jejstz7aWyu1L/+k5TbUqgwuWZ/ctMpiZjCs94xtgbp7LQhsMgMl81IGL
         cW0aw6dxOZH54WBKI4IQz0TvEnUJIPaSLGQLWfN5QY9agigXbqaliQb/LydZRsmLFwf/
         qKuA==
X-Received: by 10.140.151.197 with SMTP id 188mr16582442qhx.18.1429511381742;
 Sun, 19 Apr 2015 23:29:41 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Sun, 19 Apr 2015 23:29:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267455>

I'm trying to make my git server sends http messages in non-ASCII
encoding. And I have a question.

At 206-218 in remote-curl.c:

> static int show_http_message(struct strbuf *type, struct strbuf *charset,
>                  struct strbuf *msg)
> {
>     const char *p, *eol;
>
>     /*
>      * We only show text/plain parts, as other types are likely
>      * to be ugly to look at on the user's terminal.
>      */
>     if (strcmp(type->buf, "text/plain"))
>         return -1;
>     if (charset->len)
>         strbuf_reencode(msg, charset->buf, get_log_output_encoding());

What happen if the message has a character which cannot be encoded by
the encoding defined by i18n.logoutputencoding? Drops only the
character or brakes the whole message?

-EungJun
