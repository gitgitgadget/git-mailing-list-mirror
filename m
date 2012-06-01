From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH v2 3/6] vcs-svn: prefer constcmp to prefixcmp
Date: Sat, 2 Jun 2012 02:43:02 +1000
Message-ID: <CAFfmPPN1w+h06sYyEBrVsBy0dmKzh0audDMEZHww21tH2Yy0Fw@mail.gmail.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
	<1338475290-22644-4-git-send-email-davidbarr@google.com>
	<7vfwaf3sll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaUwS-0000Vq-1l
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965504Ab2FAQnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 12:43:05 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44518 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965382Ab2FAQnD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 12:43:03 -0400
Received: by ghrr11 with SMTP id r11so2237120ghr.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=+gtGnUrbtGDJ7fn3QeOX25lSry3oCzxZAzZS/IRHVVw=;
        b=af7jNOMPnrLLTlCK8GN6T/4qLmhMy+TbD0dxom0DiYZC9DC2M29wgcfTgfrb1VWPQy
         c55j09SjfePupu72o2BvuMN7Sf77PbDbO9v8gpyH+iZGg6tdW7HQ1MIGMMGx+zUR/duP
         A7VizyH+xpmGPBZvd20gNdvzC7RoRRe/vrtRBJKL0cefOoMwjMixl/ls5MxramhKjz86
         VY56DKY/TthPdCSLTvUylWQC1FaZI3yp9p4UxziLfAxR9/sAsI2YxSdRHNDZiyw25g5C
         aMY4shHUh6EDwJzIJhUVmfkq2cL+N2E5s0AhuGOZ35RChPNRpy3eFL9vk4LBFQM6O0F/
         twoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=+gtGnUrbtGDJ7fn3QeOX25lSry3oCzxZAzZS/IRHVVw=;
        b=TCH035z20gEsKUvWZMKwKOhLhFXS0iMveY1UZ0sohn0yB0Qrzc6gRV3gQ42cEq1u2q
         6VVxwa6SR+juwN1qJwoIbBRJJQbWni+Blw+b9YaGrl2PaNIN98bZ35Thpytgks1RMTvE
         lnXS7ydB1X7cJDZt92BValUEDwk/MLpUmXY3R+7GQG9F1Bs87SFheXRNwFI7wgTS8cKw
         3K01BGyw/ENI9DCtxyDJDM5xrvwo4lokqT6pGC36UkjJY9RTtkv0RB8165NSOf7cg2AZ
         UMnb7W3DbBIqxQ5ifM9EeadlFk31DZJjeu5vbQWti7+G3UHxriVzbVHVOl93GEatvzBZ
         1UPg==
Received: by 10.236.37.225 with SMTP id y61mr3342815yha.119.1338568983048;
        Fri, 01 Jun 2012 09:43:03 -0700 (PDT)
Received: by 10.236.37.225 with SMTP id y61mr3342801yha.119.1338568982916;
 Fri, 01 Jun 2012 09:43:02 -0700 (PDT)
Received: by 10.101.170.36 with HTTP; Fri, 1 Jun 2012 09:43:02 -0700 (PDT)
In-Reply-To: <7vfwaf3sll.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk4Km4kg25WEFuqNLgQ1QnD3X2rz72+iaHLw4zpKDSL5yclBjAJIvSgKwal0J+XdXVrvFxlYrrs0wNOvuDlavRIwJtssB43atEJ3MY6dnUIngPRoyBbrAQFyxjvsRpMTioGb1L8J31BX5BMuzqNcIpLa5GsAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199001>

On Sat, Jun 2, 2012 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David Barr <davidbarr@google.com> writes:
>
>> Comparisons in svndump.c are always guarded by length.
>> As a bonus, elimate dependency on prefixcmp for upstream.
>>
>> Signed-off-by: David Barr <davidbarr@google.com>
>
> It feels suboptimal, from cross-project maintenance point of view,
> that "do not use prefixcmp() in the source in this directory" has to
> be an unwritten rule. =A0Is there something we can do better to avoid
> having to apply a patch like this in the future?

I should note that constcmp() is local to vcs-svn/svndump.c.
In this particular case, using prefixcmp() was a departure from the
style of the surrounding code.

Should prefixcmp() be referenced outside svndump_read() and
handle_property(), I'll handle the dependency upstream.

>> =A0vcs-svn/svndump.c | =A0 =A02 +-
>> =A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
>> index 0899790..8d0ae9c 100644
>> --- a/vcs-svn/svndump.c
>> +++ b/vcs-svn/svndump.c
>> @@ -361,7 +361,7 @@ void svndump_read(const char *url)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset_rev_ctx(atoi(val))=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case sizeof("Node-path"):
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prefixcmp(t, "Node-"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (constcmp(t, "Node-"))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!constcmp(t + strlen=
("Node-"), "path")) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acti=
ve_ctx =3D=3D NODE_CTX)

--
David Barr
