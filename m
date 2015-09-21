From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Mon, 21 Sep 2015 19:54:29 -0400
Message-ID: <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
	<1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
	<xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
	<E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeAuo-0007xU-JN
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 01:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbbIUXya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 19:54:30 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35657 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163AbbIUXya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 19:54:30 -0400
Received: by vkao3 with SMTP id o3so75578142vka.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7WH7BZ9eufiE4FWUIsQcjutHtWkplgpGnpVNJ3C2w2Q=;
        b=bLHpIRAoelzTl0tD9DQ1nPThMgqqv/bGkPDI485q8UGjw/NSt3L2zFmMa0gES2Vyzx
         92G0WQIza8SmkULfM665x0KpdHtOoqL0lgRawhHVV5eaGaoKsunitVVO3pbIdOQa3AMk
         cKdOvFvawYI1Ciktsw6mg5bSGNLk9/45GHIx94kz/lWSYAEUXsRrn9IF3b4q1c+Lu4Ax
         RHw5trXeN9rGacqQTohP63X56kp4oKVvgWpAQjNk+cOrDPm1uCBFfS69f8sJyNjujKQk
         qxuvibvfUxoipsmh1Ex+PrHrp1LJXeTF0DhqSZTB1Dg8kSrod8+R3PpZWEN16smddppu
         KfQQ==
X-Received: by 10.31.6.20 with SMTP id 20mr15389080vkg.151.1442879669193; Mon,
 21 Sep 2015 16:54:29 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 16:54:29 -0700 (PDT)
In-Reply-To: <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
X-Google-Sender-Auth: Y45827JM_AEw-_vcV3_gTA1b9Oc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278361>

On Mon, Sep 21, 2015 at 7:03 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 21 Sep 2015, at 20:09, Junio C Hamano <gitster@pobox.com> wrote:
>> larsxschneider@gmail.com writes:
>>> +test_expect_success 'init depot with UTF-16 encoded file and artif=
icially remove BOM' '
>>> +    (
>>> +            cd "db" &&
>>> +            p4d -jc &&
>>> +            # P4D automatically adds a BOM. Remove it here to make=
 the file invalid.
>>> +            sed -e "$ d" depot/file1,v >depot/file1,v.new &&
>>
>> Do you need the space between the address $ (i.e. the last line) and
>> operation 'd' (i.e. delete it)?  I am asking because that looks very
>> unusual at least in our codebase.
>
> Well, I am no =E2=80=9Csed=E2=80=9D pro. I have to admit that I found=
 this snippet
> on the Internet and it just worked. If I remove the space then it
> does not work. I was not yet able to figure out why=E2=80=A6 anyone a=
n idea?

Yes, it's because $d is a variable reference, even within double
quotes. Typically, one uses single quotes around the sed argument to
suppress this sort of undesired behavior. Since the entire test body
is already within single quotes, however, changing the sed argument to
use single quotes, rather than double, will require escaping them:

    sed -e \'$d\' depot/file...

Aside: You could also drop the unnecessary quotes from the 'cd' argumen=
t.
