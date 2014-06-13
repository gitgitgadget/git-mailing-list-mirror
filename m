From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 19:16:53 +0200
Message-ID: <539B3205.5010208@gmail.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io> <1402601942-45553-4-git-send-email-caleb@calebthompson.io> <20140613065942.GB7908@sigill.intra.peff.net> <20140613163644.GB85151@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvV66-00018T-8k
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbaFMRQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 13:16:58 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38402 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaFMRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:16:57 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so1277196wib.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PlG+FrGLTwChHOyrPgmdalGiVlEUU5BcgxRhDRcyizk=;
        b=AMEeNIQQI/0o2ptMthzlxQzT69JpJ9/16HpggRy5Hz0he1FlKBpCDXyZJKhpFol4n/
         lYGj/KxLP1a25sdfhjwfLclNrcoI1ABNiekw3VO9i7EiyLyRumgaM3yQelY5bddLtFFO
         V/d3whfujFoJ14Z9iAx230UqLWbgEg6zX8uPhCHrwAqkhHKCb2fjArpPDsEbp9ZQQFjm
         G78HqlXbp9AL2jfPf72WzQdlcAUclMhD9U+9lVIFr4G+4zOLpJyQZYjZNrb4AUloFyRQ
         vPWAFO9/UQ8fuOIJ4jxFU4sOwanaCuUGnNonsltun6qH/EGa2ClLHN0w2ZBEfy+WfxTh
         Mvyw==
X-Received: by 10.180.14.132 with SMTP id p4mr6415080wic.55.1402679816536;
        Fri, 13 Jun 2014 10:16:56 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id l41sm13089427eew.8.2014.06.13.10.16.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 10:16:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140613163644.GB85151@sirius.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251617>

W dniu 2014-06-13 18:36, Caleb Thompson pisze:
> On Fri, Jun 13, 2014 at 02:59:42AM -0400, Jeff King wrote:

>> [1] It might make sense for test_set_editor, when run from within a
>>      test, to behave more like test_config, and do:
>>
>>        test_when_finished '
>>          sane_unset FAKE_EDITOR &&
>>          sane_unset EDITOR
>>        '
>
> It might, but it's a little out of scope in addition to your concern
> about other test scripts.
>
>>
>>      I don't know if there would be fallouts with other test scripts=
,
>>      though.
>
> How is this for a reword of that commit description:
>
>      t/t7507-commit-verbose.sh was using a global test_set_editor cal=
l to
>      build its environment. The $EDITOR being used was not necessary =
for
>      all tests, and was in fact circumvented using subshells in some
>      cases.
>
>      To improve robustness against global state changes and avoid the
>      use of subshells to temporarily switch the editor, set the edito=
r
>      explicitly wherever it will be important.
>
>      Specifically, in tests that need to check for the presence of a =
diff in the
>      editor, make calls to set_test_editor to set $EDITOR to check-fo=
r-diff
>      rather than relying on that editor being configured globally. Th=
is also
>      helps readers grok the tests as the setup is closer to the verif=
ication.

This also allows to run only specified subset of tests
with TEST_SKIP without requiring to remember which tests
are setup tests and have to be not skipped, isn't it?

--=20
Jakub Nar=C4=99bski
