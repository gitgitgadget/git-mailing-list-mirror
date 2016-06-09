From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Thu, 9 Jun 2016 17:39:15 -0400
Message-ID: <CAPig+cTAQAnTwQ7=Akw7N6FJS6jKc7hmZFVW=03b9NVD9+22ew@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:48:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7fk-0004B5-64
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcFIVjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:39:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36002 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFIVjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:39:16 -0400
Received: by mail-it0-f66.google.com with SMTP id h190so6773720ith.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UKRjBps3aOM7ETbVwOPTtI3HgdbK/HtpcDKMJnbmn6w=;
        b=dOEjc2fJX4WXLrumATLXqpt/vR4K8SlGp3zLRxfHXVj8nRVUx4clHsamIvUjw1Nzy1
         7JKnPhGxTmCHRJpEQOeJOMvSg8rRnhC423nn7iUjsnfsmZ5PnITIbrz9c6qLkvRWQ4ab
         OYIWr7VdzEtuX0T3p4tz71Sn/1nQGz/gyIZ4nXDbKlg+5Y4mtCpspd+YSUdJVjU0SKIy
         QyScVyk4irhmZibtcvd6+NjvC9SUhPuWlg9HoCEaynmNY06m9qaYBNYyXY5QFZC68NUR
         vJkoNiuPm+MyO8QRt+wscknK5D7HxbEqW6Guffl0frsBtA7fQfDKMs1533/3b3sCYo/C
         W8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UKRjBps3aOM7ETbVwOPTtI3HgdbK/HtpcDKMJnbmn6w=;
        b=BKFtb4tRER8taNjh2dl/PYjgBemeqXmdLka3Pci11nlPpSmXwqF3MnXPwt2RXQ2000
         aW8Srl53hFIpXUV6FB4HXlKjDBVxeLUjbf1Jl8i0hplZBp/LnYHvfjQmF25bPNJ0fb2X
         JL9eTE6YJzmQnK9tTkxyUNdDojNeqWt0hPWKStbccG06ZZaxZvzqhUhDjhuv7Ga6CgKX
         mQ81sLlLw9FYlOIO07qvXRtpiMkwpzO9Jtm9liVybAKqURb+29CoBczaFgxVN53cgeu7
         1xaxvmMRbLjPQiHZhnnHcCJw9JugccjJSb3j1Pp6tUijZbz+LuISOxX9NGPJQLBAyu4y
         vUlQ==
X-Gm-Message-State: ALyK8tJxzz+3lWIt/fD3ZgZNsg9RnDwqAe+bgkCluuPB+AbTYTVhs1POdK5ZmLAC6V+L0ZC1pmaKExNLo1X6sA==
X-Received: by 10.36.207.137 with SMTP id y131mr26410108itf.32.1465508355629;
 Thu, 09 Jun 2016 14:39:15 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Thu, 9 Jun 2016 14:39:15 -0700 (PDT)
In-Reply-To: <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
X-Google-Sender-Auth: wPl_qM2ckeFbXD82mvoYjRMII0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296932>

On Thu, Jun 9, 2016 at 5:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> +       strbuf_trim(&actual_hex);
>> +       return !strcmp(actual_hex.buf, expected_hex);
>
> Thus, it only ever gets to this point if the file exists but is empty,
> which is very unlikely to match 'expected_hex'. I could understand it
> if you checked the result of strbuf_read_file() with <0 or even <=0,
> but the current code doesn't make sense to me.

By the way, this is also leaking strbuf 'actual_hex'.
