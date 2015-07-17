From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 15:43:15 -0700
Message-ID: <xmqq380m1k3g.fsf@gitster.dls.corp.google.com>
References: <1437142912-25380-1-git-send-email-zoe@bytenoise.co.uk>
	<xmqq1tg63dzv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Zoe=CC=88?= Blade <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 18 00:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGELi-0003On-GX
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbbGQWnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 18:43:18 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34262 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbbGQWnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:43:17 -0400
Received: by pacan13 with SMTP id an13so67869190pac.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=dBRIdtHMdb+DubgUlefL4RY+ppsY6EZLFnHmH5duA6s=;
        b=C+kzfFof1AaTEe94qwNiBCYpqzWwkN5OxDKV1+dH6qcs1Hnl0DPOgCB8bGUWQzBeom
         +U29cHzXOsPxVJKCB1yClrrhOLGL1BZKLzuoUs/1LGNiavdc73JPuvPbXuMe31XALxls
         PlfTRhUQ+ik65K/BXnwv+/js1+1heojkD5K0NN8tGO8cndrbd0k1+hm+Am/5BmkmBVY+
         Y7iQKJ0CpfkN+smd8kb+FKTR5J5N39FxSR6otTIWHAyce9KdDoKxGBCu+9MhkmRYXGu8
         ieKQf47qj8OC5SuHKb3EopGcirVn0mx6gZgr05vRZlfKJNjxXGeqFn6CUCvS17cVbCuV
         NgOg==
X-Received: by 10.69.12.136 with SMTP id eq8mr33602639pbd.88.1437172997394;
        Fri, 17 Jul 2015 15:43:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id no6sm12372514pdb.42.2015.07.17.15.43.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:43:16 -0700 (PDT)
In-Reply-To: <xmqq1tg63dzv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Jul 2015 10:12:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274127>

Junio C Hamano <gitster@pobox.com> writes:

> Zoe=CC=88 Blade <zoe@bytenoise.co.uk> writes:
>
>> More information about the Fountain format can be found on its
>> official website, at http://fountain.io .

So I visited there.

>> +PATTERNS("fountain", "^((INT|EST|EXT)?\\.[A-Z0-9' -]+)$",
>> +	 "[^ \t-]+"),

After skimming http://fountain.io/syntax I am getting the impression
that this might be a bit too limiting.

 * Although uppercase is recommended for Scene Headings to increase
   readability, it is not required.

 * A line beginning with any of the following, followed by either a
   dot or a space, is considered a Scene Heading (unless the line is
   preceded by an exclamation point !). Case insensitive.

      INT
      EXT
      EST
      INT./EXT
      INT/EXT
      I/E

 * You can "force" a Scene Heading by starting the line with a
   single period.

 * Scene Headings can optionally be appended with Scene
   Numbers. Scene numbers are any alphanumerics (plus dashes and
   periods), wrapped in #.

So, it appears wrong to insist on capital letters in the patterns.
The pattern in the patch does not even accept punctuations on the
line other than apostrophe.  I won't judge if it is OK to limit to
US-ASCII ;-)

IPATTERNS("fountain",
    "^([.][^.]|(INT|EXT|EST|INT./EXT|INT/EXT|I/E)[. ]",
    "[^ \t-]+"),

or something like this, perhaps?
