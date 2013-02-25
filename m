From: Zubin Mithra <zubin.mithra@gmail.com>
Subject: Re: Certificate validation vulnerability in Git
Date: Mon, 25 Feb 2013 07:58:11 +0530
Message-ID: <CAA5xPpm=5NP=uDkEWBSosOE=0Jp1MBD5qG7sHKxCUsv6iZ59tg@mail.gmail.com>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
	<512A601B.80807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Dhanesh K." <dhanesh1428@gmail.com>
To: ae@op5.se
X-From: git-owner@vger.kernel.org Mon Feb 25 03:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9nnx-0004PJ-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 03:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759640Ab3BYC2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 21:28:12 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:33832 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759464Ab3BYC2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 21:28:11 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so1244318dak.14
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=FfCjrEfEnx3nq7SZS9mt6E4Lttb1OGXmO+TgY6Fj8h0=;
        b=u7SHR1b08zq1ROz9GU1JITjPwviCEVH2Dy03gvcRqpZAXp7f7ONXyktU9wosj0PWnu
         in5SQyNQfMpLB6LD9asLUp43Tw9IvtG0WYpZKb3JilF3rQPq+271e1dnteL7peFn8Azn
         vPeEPKcvPYfY9Sgaw55SMKHIhwH79WtA1Tml/ev5KD/A8rhaGLqUy3MCXpPBXCrxegxm
         ks0frueYu5AKi/l4tiRcfCNOOdYTlnLY9QiM4ykJAnVxXhvaFwzv9NJY6e8HdpTTFSsk
         x1EcDWG2qYWIq4OVRk/atsQVB4+bf2SiTPaUzC2jFxO+a7TYbHmPux9LG3A7eQl2nuk1
         xbug==
X-Received: by 10.68.39.129 with SMTP id p1mr15840160pbk.19.1361759291087;
 Sun, 24 Feb 2013 18:28:11 -0800 (PST)
Received: by 10.68.42.36 with HTTP; Sun, 24 Feb 2013 18:28:11 -0800 (PST)
In-Reply-To: <512A601B.80807@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217023>

Hello,

On Mon, Feb 25, 2013 at 12:16 AM, Andreas Ericsson <ae@op5.se> wrote:
> On 02/24/2013 06:31 PM, Zubin Mithra wrote:
>> Hello,
>>
>> There seems to be a security issue in the way git uses openssl for
>> certificate validation. Similar occurrences have been found and
>> documented in other open source projects, the research can be found at
>> [1].
>>
>> -=========]
>> - imap-send.c
>>
>> Line 307
>>
>>   307   ret = SSL_connect(sock->ssl);
>>   308   if (ret <= 0) {
>>   309     socket_perror("SSL_connect", sock, ret);
>>   310     return -1;
>>   311   }
>>   312
>>
>> Certificate validation errors are signaled either through return
>> values of SSL_connect or by setting internal flags. The internal flags
>> need to be checked using the SSL_get_verify_result function. This is
>> not performed.
>>
>> Kindly fix these issues, file a CVE and credit it to Dhanesh K. and
>> Zubin Mithra. Thanks.
>>
>
> The lack of certificate authority verification presents no attack vector
> for git imap-send. As such, it doesn't warrant a CVE. I'm sure you'll
> be credited with a "reported-by" line in the commit message if someone
> decides to fix it though. Personally, I'm not fussed.

I'd like to add in a few points -- generally SSL/TLS would be used in
cases where the authenticity of the server and confidentiality of the
messages transferred would be required. In this particular case, the
threat scenarios would be :-

- Usage of an invalid attacker certificate could result in the
attacker gaining access to authentication information sent over the
wire.
- If the code repository were private, the patches thus generated are
also assumed to be kept private. An invalid certificate check at the
client side would enable an attacker to gain access to those patches.


Is there anything I'm missing? I believe this is a valid security issue.



Thanks,
Zubin


>
>> We are not subscribed to this list, so we'd appreciate it if you could
>> CC us in the replies.
>>
>
> That's standard on this list. Please follow the same convention if/when
> you reply. Thanks.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
