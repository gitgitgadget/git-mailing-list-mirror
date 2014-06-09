From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v1 0/5] add strbuf_set operations
Date: Mon, 9 Jun 2014 17:39:12 +0700
Message-ID: <CACsJy8D_eM9OtH=6Z_F0P7GZpqmAdSCEnBjCr_gniZr649P1uw@mail.gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 12:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtwzU-0008QY-Er
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 12:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbaFIKjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 06:39:45 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:54553 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbaFIKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 06:39:43 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so8670825qgf.31
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=btCMzlmyc+xDhsWxdvUfFzyIE10cUr22vdh+4OFDi9s=;
        b=kfY9eLBc/MpsBkVngMIV1fbJE9jTjdHINq9iLcMfoepKdugh1WGi7e7L55t3ZFzCWT
         sdKMlmMOObEsmVsMISZhhL0RYLQfxgcv8nyvkwGMO+oJocP6Wm8nnTfobLDD0+tjEnWk
         66xMEkEThBTluqg8l+IAy0kPN9BmdrWuAjs0AKeKjvVrSLBtOkUg7/D8aDc0KiXMjPgb
         zH7fK/91XGgZZ43d2pOr7COb2eRG/N0ERcdS89oFmAyuuhx1RL709Yq9HhR9aykdGLza
         pyU12VJH6tCNi0xG+lRpznik529j6NDo+/P2ixqP/8bWWLoc2Ha9o+wvW0xGmgynk05g
         RwBg==
X-Received: by 10.140.92.200 with SMTP id b66mr28799689qge.41.1402310382932;
 Mon, 09 Jun 2014 03:39:42 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 9 Jun 2014 03:39:12 -0700 (PDT)
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251068>

On Mon, Jun 9, 2014 at 3:36 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Currently, the data in a strbuf is modified using add operations.  To
> set the buffer to some data a reset must be performed before an add.
>
>   strbuf_reset(buf);
>   strbuf_add(buf, cb.buf.buf, cb.buf.len);
>
> And this is a common sequence of operations with 70 occurrences found in
> the current source code.  This includes all the different variations
> (add, addf, addstr, addbuf, addch).
>
>   FILES=`find ./ -name '*.c'`
>   CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)

Hmm.. I wonder if git-grep could do this.. There's pcre support but I
never tried.

>   CNT=$(echo "$CNT / 2" | bc)
>   echo $CNT
>   70

The change in this series looks nice. There's another pattern, save
strbuf length, then strbuf_setlen() at the beginning or the end of a
loop. But I think it's less often.
-- 
Duy
