From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] git-p4: fix faulty paths for case insensitive systems
Date: Wed, 5 Aug 2015 07:36:37 +0200
Message-ID: <42A92EAD-493D-458C-9D8B-BDC78E1A1614@gmail.com>
References: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com> <55C1374E.5060808@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pw@padd.com, torarvid@gmail.com,
	ksaitoh560@gmail.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:36:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMrNg-0004ev-Jo
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 07:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbbHEFgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 01:36:44 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36224 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbHEFgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 01:36:43 -0400
Received: by wicgj17 with SMTP id gj17so177338256wic.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h9kEvQhSD0Ud5Mgych+vR+HoHEd84nnhJOPc8ENEnlw=;
        b=hbJ1se7Kd3mQuV3K7fQ/Kd+jKMpxPLVHlQUMGIML4V4bdoQCYymrSAIRbHcExFaxL4
         Hz7rEycPIknfYbjAR8ia4O/i3PZAudf5AM+cbGOI8BuI0T/PNPd/2suHouCFV2JVdJm+
         EYZFwxte6m8cngO7lo8xonII7JQKVkPCSUA30/idklWW8BujSrcj1p2Wbol4CD45tIci
         +IcldmA+6hN9Nr/naMOKO3qrlskq7q6Vi95u5g1StPKs8b526SIBxdgHtXzKy6zic5Q/
         qjzfpxkPvAu7vrA94ch0eY53dsOeJYqkLd2Ggb+4B7WoNN9GdNCFYemakUwnLex9SDyO
         p+aQ==
X-Received: by 10.194.122.200 with SMTP id lu8mr15270714wjb.83.1438753002120;
        Tue, 04 Aug 2015 22:36:42 -0700 (PDT)
Received: from [10.32.249.107] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k4sm5701620wix.19.2015.08.04.22.36.40
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 22:36:41 -0700 (PDT)
In-Reply-To: <55C1374E.5060808@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275350>

Thank you for your reply. Your t8919 test case looks exactly like the r=
ight thing. Unfortuantly I don=92t have Internet access for the next tw=
o weeks. Afterwards I will provide a proper test cases for the patch.

You are correct about the speed. All these initial =93p4 dirs=94 calls =
make the clone pretty slow. However, for us it is a one time history mi=
gration and therefore speed is not an issue. I also understand your =93=
core.ignorecase=94 comment. Let=92s assume the path correction works as=
 expected, how and when would you trigger it? Would you only rely on th=
e =93server ignoring case=94 flag?

Cheers,
Lars

On 05 Aug 2015, at 00:06, Luke Diamand <luke@diamand.org> wrote:

> On 02/08/15 16:15, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Hi,
>>=20
>> I want to propose this patch as it helped us to migrate a big source=
 code base
>> successfully from P4 to Git. I am sorry that I don't provide a test =
case, yet.
>=20
> Case sensitivity is a pretty tricky area with p4 - it's very brave of=
 you to have a go at fixing it!
>=20
>> I would like to get advise on the patch and on the best strategy to =
provide a
>> test. Do you only run git-p4 integration tests in "t/t98??-git-p4-*.=
sh"? If yes,
>> which version of "start_p4d" should I use?
>=20
> Only the t98* tests relate to git-p4 so if you just copy one of those=
 it should do the right thing.
>=20
> t9819-git-p4-case-folding.sh already has a few failing tests for this=
 problem. I wrote it a while back just to illustrate the problem, so it=
 might be of use to you, or you might need to start again.
>=20
> Won't your change make importing much slower for people with this pro=
blem?
>=20
> Also, I'm not sure you can use "core.ignorecase" to trigger this: the=
 problem will arise if the *server* is ignoring case as well (which I t=
hink you can detect by querying the server).
>=20
> I'm not trying to be negative - but this problem does have some annoy=
ing pitfalls! Let me know if you think I can help though.
>=20
> Regards!
> Luke
>=20
