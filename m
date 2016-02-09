From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue, 9 Feb 2016 14:19:42 -0800
Message-ID: <CAGZ79kYm79C7tLECeJCrS3JoCudUT-8geovoMpT8qoHpYBjUAg@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-2-git-send-email-sbeller@google.com>
	<xmqqh9hh382i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:19:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGdQ-0001cS-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbcBIWTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:19:44 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:36063 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbcBIWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:19:43 -0500
Received: by mail-io0-f171.google.com with SMTP id l127so2763562iof.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/v4XB+nbBfDtCJ3Gwmj4ipdwvbvW5Zz/qHEBTY5o2MQ=;
        b=AFPmf3dYbbhsuhQ+eVZ8CFIF7yYfXjW4WrjMq+9NFAVMLGKXQ6Lr2Aoz6pUysM/99Z
         Mgy+PXwV7Y1jbUj5xq8PAlU/cv4/sS+QxZp4IPXEKJdh8GEc23QAOzSTOVNrYbiyqlP2
         mzlbY3fpKMQ//ZDBsmHReSwawmBpOjrcXcbBeEnwi+WrRU6fTqRe3dUVeEDZQ/FhI2rY
         /vab1KXQ+sJXojl+AchUd5yQHLbON6EO8BW+2Xd8NOA62t0+Mhp0FDKikmA5woKA2TZo
         XXLCudWBwHXI7aJxKew69RHxrTQL2bZubIGrqu2uyV2H447QBDFw/obNo55OZFOwyBeZ
         EkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/v4XB+nbBfDtCJ3Gwmj4ipdwvbvW5Zz/qHEBTY5o2MQ=;
        b=A2zg5+PwjRmwNH6BGnluGns3uLmbV7Jz37HT5DyG4FI4E5J1g1uXf9v3az9ngiHVCq
         mLpCGNaLUbNd+58KwBzRBNXesU25DcNtWYUSzHIxJUOTTWKd0Hu1fIJFji5ReHFaOiN3
         Frz+oJl5kHFF4L+eSOce8Cc2/BjTJQkKc9Kn3Klng9tPe8/5ShOVHxpYoJMP6zz9Xml1
         sJIR242npruMa6fsbcy+0PZ7mloHHGSRYKLlLzICkUVj1QQY5A2f94YI9MQaN6LLAzin
         mJvfGONLDLnn1VwpCd08xcv2H9sfxPN88gfhREiOWGVrjVWBnmU6D7W0tf+yv3ThFwwc
         TTtQ==
X-Gm-Message-State: AG10YOQvmj81Vw+fsF/viZ9g9XgQUBWYbzb5G2H+eUd7B5M2fZPcR/BWxlkAoIR1X0EC0Cb7Qm8MAIqSXsdLiTCk
X-Received: by 10.107.168.149 with SMTP id e21mr34957942ioj.96.1455056382995;
 Tue, 09 Feb 2016 14:19:42 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 14:19:42 -0800 (PST)
In-Reply-To: <xmqqh9hh382i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285875>

On Tue, Feb 9, 2016 at 1:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     } else if (!strcmp(item.buf, "update")) {
>> +             if (!value)
>> +                     ret = config_error_nonbool(var);
>> +             else if (!me->overwrite &&
>> +                 submodule->update != SM_UPDATE_UNSPECIFIED)
>
> Funny indentation here (locally fixable).

I looked through the code base and reread our CodingGuidelines
to find out what is considered correct. (I assumed we had a gnu-ish
coding style w.r.t. breaking overly long lines in conditions, which is
having the next line be indented with 4 spaces.)

So I assume by funny you mean "the next line doesn't start below the
opening parenthesis"?

That would seem to be consistent as it fits both the 4 space indentation
which is always found below "if (", but we have more than 4 spaces in
other places such as overly long return statements, i.e. refs.c, l 610
(@origin/master)
        return starts_with(refname, "refs/heads/") ||
                starts_with(refname, "refs/remotes/") ||
                starts_with(refname, "refs/notes/") ||
                !strcmp(refname, "HEAD");

which also doesn't seem to align perfectly to me.

Looking for places, which have the pattern "else if (..." with line
break, I found several different styles.

builtin/mv.c (@origin/master) has two occurrences of

    else if (...
    <2 additional tabs> condition continues here

and another of

    else if (...
    <1 tab + 1 SP> condition nearly aligned to statement below

Looking at remote.c, I can find 1 tab, plus 3 spaces.
...
Giving up to come up with an idea for space based rule other than
"visually align it below the original statement".

Puzzled,
Stefan
