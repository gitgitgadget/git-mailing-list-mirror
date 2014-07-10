From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Wed, 9 Jul 2014 21:14:32 -0700
Message-ID: <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
 <xmqq61j69m0m.fsf@gitster.dls.corp.google.com> <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 06:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X55l5-0007ef-Up
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 06:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbaGJEOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 00:14:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41055 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaGJEOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 00:14:54 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so5681164lbd.33
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/DZs2rb5RRHH2sQW2UFRLE0tr3R+8wIzJvyC+Yb2n8E=;
        b=Av4hFV/PMG7z+lPtltdVzI+iGJld8ijdH+RlUccCDah+Owqkpv4BUYKRavqv3FEqWZ
         c3qLmhv7KFOHGns6IEHF48wOoV9oLVuDt7WIYlZI89xWOl0csKXyQcXYE1VjV6kFjEtI
         Z73dlrKBG/fCbtSj3V9Q1tVr7blPSc1FUshTuv1m5or+uWuzsQSW6c7Y09xsh/Xb+unf
         ZTlFvOKlgUmnL2OHcm4m8KlvR6z0KykRryfitlP2kSKYoLBFdrO1JZAqh0gMjTkWMpzA
         xdmw2TJ3n6wEeqT01Caw16ookUbkhJBIba7sqobYbrE2jNHwuMbPSHjOHRhTD6DDjftC
         w6Og==
X-Received: by 10.112.218.74 with SMTP id pe10mr33782711lbc.3.1404965692208;
 Wed, 09 Jul 2014 21:14:52 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Wed, 9 Jul 2014 21:14:32 -0700 (PDT)
In-Reply-To: <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
X-Google-Sender-Auth: SYIjEkW1-C8v_7h3yrMKNyXytSM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253174>

On Wed, Jul 9, 2014 at 4:49 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
> On Wed, 2014-07-09 at 15:59 -0700, Junio C Hamano wrote:
>>
>> What kind of things are missing, exactly?  Perhaps that is something
>> you need to fix, instead of mucking with the top-level Makefile.
>
> It uses the git from my environment instead of the git I have built,
> which is bad since I don't really want to run make install.

Are you sure about that?  Try adding something like

  die("I am broken");

at the very beginning of main() in git.c, rebuild your git (i.e.
"make", not "make install")
and then

  $ cd t
  $ sh ./t1234-test.sh -v

for any of the test scripts. You should see any test piece that runs "git" sees
"git" dying with that message.

Otherwise, there is something wrong with git you are building. Unless you have
a patch or two to t/test-lib.sh or something that breaks the test framework, you
should be able to test what you just have built without getting affected by what
is installed in your $PATH. After all, that is how we bootstrap git
from a tarball
without any installed version, and friends do not force friends install without
testing first ;-)
