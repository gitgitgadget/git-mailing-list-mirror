From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 18:00:52 -0500
Message-ID: <CAMP44s3L6X=iWK7S-JFqp42PmNx4xbh-GnPJpAgur4FGoZYNbg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
	<CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
	<7vbo8vabet.fsf@alter.siamese.dyndns.org>
	<CAMP44s02QkL7QAuHHm_uT6B4QCzk9Mur0_w_D8t2A2u1go2F8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 01:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJXg-0000km-0M
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 01:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751Ab3D3XAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 19:00:55 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34166 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643Ab3D3XAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 19:00:54 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so1031078lbd.33
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Bzv2skxDkPuCj6JK9wLxbXaESE+gYlo1KPa49kruSOc=;
        b=SsccB+nvZ3joT0BvhGP4lvoPpsvlXgIUh+t8Ruq8oKrTFrPRhUNe99xdlL+ea2fOBG
         C9chbhTrgc0yPpSpGcqR8fhiw3foaSSKKVTlDi6tc2BtiZUYnrSmZjBuX6QiICarXJR+
         pt/VEA47D5ZqsEyTvdKUagKvdShUkeq5lpdlW7uQril7PbR4RhYOW4u0gfQuMRQrtoKj
         8CMyMKGn1D/bssonQInCdODF9c45ZZxDVDf3XGyfO64hMkDKNSqXmxwWZhRuNl8WQRJw
         95tV17OkBf6RtawQiaIfq//ZpZ6YLIj3C7unOZmz8k2De3h22bQ2y8PcdsrBIMHGGQQV
         Nypw==
X-Received: by 10.112.22.198 with SMTP id g6mr312586lbf.135.1367362852956;
 Tue, 30 Apr 2013 16:00:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 16:00:52 -0700 (PDT)
In-Reply-To: <CAMP44s02QkL7QAuHHm_uT6B4QCzk9Mur0_w_D8t2A2u1go2F8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223039>

On Tue, Apr 30, 2013 at 5:53 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 5:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Since 'update-ref master' updates the 'master' ref, and not
>>> 'refs/heads/master' (IOW; no parsing at all), I think it makes sense
>>> that @{-1} is not parsed, and neither is @.
>>
>> That is a very valid point.
>>
>> What should "rev-parse --symbolic-full-name @" say?
>
> Probably the same as 'rev-parse --symbolic-full-name HEAD' (it doesn't
> with my patch).

The gist of my patch can be dropped, this does the trick:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -965,6 +965,21 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
        return st;
 }

+static int interpret_empty_at(const char *name, int namelen, int len,
struct strbuf *buf)
+{
+       if (namelen - len < 1 || name[len + 1] == '{')
+               return -1;
+
+       strbuf_reset(buf);
+       if (len == 0) {
+               strbuf_add(buf, "HEAD", 4);
+               return 1;
+       } else {
+               strbuf_add(buf, name, len);
+               return len + 1;
+       }
+}
+
 static int reinterpret(const char *name, int namelen, int len, struct
strbuf *buf)
 {
        /* we have extra data, which might need further processing */
@@ -1025,9 +1040,15 @@ int interpret_branch_name(const char *name,
struct strbuf *buf)
        cp = strchr(name, '@');
        if (!cp)
                return -1;
+
+       len = interpret_empty_at(name, namelen, cp - name, buf);
+       if (len > 0)
+               return reinterpret(name, namelen, len, buf);
+
        tmp_len = upstream_mark(cp, namelen - (cp - name));
        if (!tmp_len)
                return -1;
+
        len = cp + tmp_len - name;
        cp = xstrndup(name, cp - name);
        upstream = branch_get(*cp ? cp : NULL);

-- 
Felipe Contreras
