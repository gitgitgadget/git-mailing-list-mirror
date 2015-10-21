From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 14/34] mailinfo: move filter/header stage to struct mailinfo
Date: Wed, 21 Oct 2015 13:20:20 -0700
Message-ID: <CAGZ79kaCA5HLF7mLY9OC_JrZ9ZhfURdcLoZxQ4rMwmMyWHf_sg@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-15-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:20:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozsQ-0002WW-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbbJUUUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:20:45 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34779 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbbJUUUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:20:21 -0400
Received: by ykdr3 with SMTP id r3so61790918ykd.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CxYloCOluH0v7gxhaXprjduiJHdwwN2T9a31q8lIrAo=;
        b=fwFQ/uCNWsJETfF1PyO0WTS33Ku3NO+xQ2jj6hN6hH5jUCcOPu63vbQKuvsxoREHCh
         nBusEY0fku/VUbVTEFAODJWGeIX/9Fd+oh2U3ziIm4eaxaU/uUpPb5q7k2r+1k7cht5P
         ZJTTBPuihhEjOGh1rYyRnPS6vAhYoCSNw6CNd88wmJXoUzpSWvsR7Gxy6Z+BKYBp0KL5
         OOeJ/tXk6EnIeUQlJgJSN77k6e0CuNW4HIB3GrzOBuc7DAflrCYme98/nZK3+HAVPhWz
         /WIISNjJZcLxDiMVraIiNU8fgryUu1QXCLfQlLJefB7T6P5puWSN2R0Bt6E0bCOQTRo8
         zkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CxYloCOluH0v7gxhaXprjduiJHdwwN2T9a31q8lIrAo=;
        b=eRNOeP3aE67EiE/cKp0vRo0rnS/PwWIzH1fc5EQsup+a5PfA93tsNYjpu2FHiWX3lr
         tRPGg54gEyxxrW9xVz8fts7JHmLqZB59lWegrLBlmZqV3VUBL1j9+IzZrmprS1Hrsb4i
         JpSrEz9wnMM/EFwv+IxT44yTT0/B7qdwUmoUfGFCcQ3N1sKaH4+ej4LPxOfjFxmjuHhJ
         aJ6awb0p/6IypEuZx4agyrL+AkMJJEf2ykHLTg17QOH0W71U7ETksr7ZLH6Pp9o6y2Jf
         ayjRTPRyszRASof7+svBoQT31ZxDV1mqd5/SK60lZXS+/5x76mAULldRmDUFKavjBkjU
         bw3A==
X-Gm-Message-State: ALoCoQnHBZfx43wnCzSkFv16MCBZr2mMmW5FDURUfKVZZe0PZkUOtt1ic7t2I+gjlNrHSlfLJVCf
X-Received: by 10.13.199.133 with SMTP id j127mr8219832ywd.176.1445458820974;
 Wed, 21 Oct 2015 13:20:20 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 13:20:20 -0700 (PDT)
In-Reply-To: <1445239731-10677-15-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280011>

On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:

> @@ -28,6 +31,7 @@ static enum  {
>
>  static struct strbuf charset = STRBUF_INIT;
>  static int patch_lines;
> +

nitpicking here. Why is this patch the best in series to introduce a
new line at this position? ;)

>  static struct strbuf **p_hdr_data, **s_hdr_data;
>  static int use_scissors;
>  static int add_message_id;
> @@ -718,25 +722,25 @@ static int is_scissors_line(const struct strbuf *line)
>                 gap * 2 < perforation);
>  }
