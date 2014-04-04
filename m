From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 06/10] log: --function-name pickaxe
Date: Fri, 04 Apr 2014 13:15:49 +0200
Message-ID: <533E9465.8070609@gmail.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>	<62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>	<533DD1B1.3000107@web.de> <xmqqwqf6ozp3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>,
	git@vger.kernel.org, peff@peff.net,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 04 13:16:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW26K-0001RO-82
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 13:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaDDLP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2014 07:15:56 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:43577 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaDDLPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 07:15:55 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so1017832wiv.13
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xmw5OSiewaSBazIBWYKymBPDrTcLUWDw3scrm/+u7xk=;
        b=akxPM4RMiVGWZt/RtGbY9/iO3phGdWkG/tV0Vct4C+s3CLikvHEWO9fihLUyS944DS
         xHV6r/wfPGp3s3ko/VNAKwvO5CordqkP7I2RUiOKPN7TJQVK9rGnqBSdVZsDrwZgtxyl
         nDhPvtilM6SFEI7oSmGgOdyLGQoYdizkGbkHNEF1TLXcIX4pzW8B916Bhp3Ne5uEr3yE
         hhbGYYPfzSz2sdDSvrnGOil1X6g5QPNhabWA/V5ZR65CHXqiJOMlp08sxNIeT2gTQ5qx
         gwMcDWyuyG++n/auNbB2zqooO3y0racaXnpovGXeIaHD2FK8VhL5f2zcudFvqDNKEGu8
         5C3A==
X-Received: by 10.181.13.112 with SMTP id ex16mr3595038wid.23.1396610154564;
        Fri, 04 Apr 2014 04:15:54 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id e42sm18846711eev.32.2014.04.04.04.15.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 04:15:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqwqf6ozp3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245759>

W dniu 2014-04-03 23:44, Junio C Hamano pisze:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> With that approach you depend on the hunk header and apparently need
>> to add XDL_EMIT_MOREFUNCNAMES and XDL_EMIT_MOREHUNKHEADS to improve
>> the results.  This approach feels fragile.
>>
>> Would it perhaps be more robust to not base the implementation on di=
ff
>> and instead to scan the raw file contents?
>
> That is an interesting idea.
>
> Perhaps this can be implemented as a new stage in the transformation
> pipeline, I wonder?  There is currently no transformation that
> modifies the blob contents being compared, but I do not think there
> is anything fundamental that prevents one from being written.  The
> new "limit to this function body" transformation would perhaps sit
> before the diffcore-rename and would transform all the blobs to
> empty, except for the part that is the body of the function the user
> is interested in.

Well, there is 'texconv', e.g.

   .gitattributes
   *.jpg diff=3Djpg

   .git/config
   [diff "jpg"]
          textconv =3D exif

Doesn't it fit in said place in the transformation pipeline?

--=20
Jakub Nar=C4=99bski
