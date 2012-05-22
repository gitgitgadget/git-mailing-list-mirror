From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Mon, 21 May 2012 23:23:17 -0500
Message-ID: <20120522042316.GA3080@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.61154.chriscool@tuxfamily.org>
 <CALkWK0m9F6EU43v0HbJxWUVtHTiw+ZvjCjwqbSVdQfomb6f4Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nick Bowler <nbowler@elliptictech.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 06:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgdA-0007um-6N
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2EVEX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 00:23:27 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44002 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab2EVEX1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 00:23:27 -0400
Received: by gglu4 with SMTP id u4so5031476ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 21:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zFbdckkZXGxdV17XD+dGqbqCGGn+AOvsJRWtFjI2EIg=;
        b=A6/Bi8gEGWuyyMAQie9dxi0kn/X1cAeyuW+Wx7NewW/db2uJBtHXM5C7Y+hbElcaCQ
         N1t8n5KyUdengqFlthA0yL5p1tI7b6dAygBOB3ovlQWk+mVEgwASMX/0SvQyjQ0gisPj
         M/uL4kmSEXJqWn2oPsDX/zFgn63gv4EkQo8caCqLOZAZ8uIvvihUUduFgCxnV+zsEhRn
         /9KLJdrFBnKTGEL3pAkzgCXMKmYI33S6zAl5jtNzDVA2DcFRCdi8Y4hgVLdzqySvjfqM
         swfgUFZty1SOny2gVuGjG/4i32kPor9SmUM8XjrQbC5IW/malEIi+jqKX/sOkyW1W7VJ
         HGpQ==
Received: by 10.50.42.136 with SMTP id o8mr8472704igl.16.1337660606213;
        Mon, 21 May 2012 21:23:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id if4sm9011707igc.10.2012.05.21.21.23.24
        (version=SSLv3 cipher=OTHER);
        Mon, 21 May 2012 21:23:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0m9F6EU43v0HbJxWUVtHTiw+ZvjCjwqbSVdQfomb6f4Aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198168>

Ramkumar Ramachandra wrote:
> Christian Couder wrote:

>> diff --git a/sequencer.c b/sequencer.c
>> index 762c527..ad1bbea 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -741,6 +741,7 @@ static void save_head(const char *head)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_errno(_("=
Could not write to %s"), head_file);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (commit_lock_file(&head_lock) < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("Error =
wrapping up %s."), head_file);
>> + =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> =C2=A0}
>>
>> =C2=A0static int reset_for_rollback(const unsigned char *sha1)
>
> Thanks.  Shouldn't we be polluting the die() pathways with this
> strbuf_release(&buf) the way save_todo() does it consistently?
>=20
> 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> 		strbuf_release(&buf);
> 		die_errno(_("Could not write to %s"), todo_file);

I don't see why.  Doesn't exit take care of freeing everything?  And
looking at it from the other side, doesn't using exit mean that you
cannot be valgrind-clean anyway, since allocations by functions higher
in the call chain do not get a chance to be freed?

Jonathan
