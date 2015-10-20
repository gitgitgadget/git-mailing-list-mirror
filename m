From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: Git-p4 fails with NameError with python 2.7.2
Date: Tue, 20 Oct 2015 18:42:20 +0200
Message-ID: <CAAToxAHdojvspxdb-=vYx-QY9=MTjnQD29fLTJK3KmY2+To5eQ@mail.gmail.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	<xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZzW-000696-6p
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbbJTQmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:42:22 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35796 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbbJTQmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:42:21 -0400
Received: by oiev17 with SMTP id v17so13371550oie.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RushMvWCQqAZlzmlGIyjALPIF0bsS4HsFHcXk6J7j3k=;
        b=deLv93FetesRYTFVLWN9xQySRfC47TtmU3hH0GuRQ+n4VAdr4GtmWrpHMJvj28LyZ2
         BKGGdAcoTLHvT5DGhQtOUoxClpJzQ9yulL7niFgXrLQF4DTgIZwEwhLMrnaQ2DDPZWJG
         O1L5zi+/71NcpY22GWVQZOJxqkOOqjg7FAZ40j+9yRF4kHhWfVfStlwMEdPtsXDoUoJw
         OyaWpqUno8fE/Pzear2T59rV6bsPQsSWetnG5DFw+6v2CvQM98gcHU9X75M/QA4t/rXu
         4dpWyrY2dRm7mBKvaSV7l2MIyGIJswmENziRD9erqsBGJhYsNVcfqdsidt0Z9vbHsr0u
         Plmg==
X-Received: by 10.202.95.2 with SMTP id t2mr2573159oib.77.1445359340673; Tue,
 20 Oct 2015 09:42:20 -0700 (PDT)
Received: by 10.182.43.199 with HTTP; Tue, 20 Oct 2015 09:42:20 -0700 (PDT)
In-Reply-To: <xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279923>

On Tue, Oct 20, 2015 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
>
> > On 20 October 2015 at 11:34, Etienne Girard <etienne.g.girard@gmail.com> wrote:
> >> Hello,
> >>
> >> Git-p4 fail when I try to rebase with the error: "NameError: global
> >> name 'ctypes' is not defined". The error occurs when I use python
> >> 2.7.2 that is installed by default on my company's computers (it goes
> >> without saying that everything works fine with python 2.7.10).
> >>
> >> I'm a beginner in python, but simply importing ctypes at the beginning
> >> of the script does the trick. I was wondering if submitting a patch
> >> for this issue is worth the trouble, when a satisfying solution is not
> >> using a 4 years old version of python.
> >
> > If you're able to submit a patch that would be great!
>
> Lars's 4d25dc44 (git-p4: check free space during streaming,
> 2015-09-26) introduced two references to ctypes.* and there is no
> 'import ctypes' anywhere in the script.
>
> I do not follow Python development, but does the above mean that
> with recent 2.x you can say ctypes without first saying "import
> ctypes"?


No.
You need to import the ctypes  module.

However in Python it is possible to "inject" the ctypes module (and
any other name) in the builtin namespace.
The builtin module contains names that are accessible without importing them:
https://docs.python.org/2/library/__builtin__.html

IMHO, some code  is messing with the __builtin__ module.

Running pyflakes on git-p4.py code I get:
git-p4.py:26: 'zlib' imported but unused
git-p4.py:640: local variable 'v' is assigned to but never used
git-p4.py:2114: local variable 'rhs_index' is assigned to but never used

Running pylint I get a **lot** of warning and style issues; and the
following errors:
E:112,21: Undefined variable 'ctypes' (undefined-variable)
E:113, 8: Undefined variable 'ctypes' (undefined-variable)
E:113,51: Undefined variable 'ctypes' (undefined-variable)
E:113,94: Undefined variable 'ctypes' (undefined-variable)
E:1002,51: No value for argument 'contentFile' in method call
(no-value-for-parameter)

pyflakes is not reporting an error for ctypes.
Whatever the cause, the code must be fixed to import the ctypes module.

P.S.:
Sorry for the double message.
The first message contained an HTML part and was rejected by vger.kernel.org.


Regards  Manlio
