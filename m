From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Fri, 9 Mar 2012 10:21:46 +0100
Message-ID: <CAJh6GrEv5FJTeH7qZ1knBY_f2ZgSLBV=smP8vA+EHqUdG1p_JA@mail.gmail.com>
References: <1331214777-9455-1-git-send-email-domq@google.com>
 <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com> <CAJh6GrHMb-H6ktEGGHxMxbZXujKFe=unYzAyS-zoGnfzMfcKQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5w1f-0004pX-LJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab2CIJWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 04:22:10 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43035 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2CIJWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 04:22:08 -0500
Received: by wejx9 with SMTP id x9so963528wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=f0A4GwmJar4RSXfu4McJKvNytWuXkPDHnCbe0gc3MQA=;
        b=FPVvAM24Dc0r7PVc/H4HbKMQPWrHNR9Mmf5IWKwBohPZl9U1yUeik8JJ9hOQwJaTwR
         E+cM1DPI56lIJoggqsM69oRwp+WUuf5WrZXT/nGY7I4rz6RkFj8bqExbNzMiA25dxEZO
         BfB354y02rxs0eMNSG3SdfSeCAY0vda3gY212r2FeM6sx0I+3mugS8BQOvgF6ZagYyMD
         RbaL8Bib4H2nZJ9R8kCgcfkF9a5w4/oHI2+VU1auHGeLsqR1CQUJBVNJ/yXmEfyGBBRb
         5CWrn7CT1Xke3gWcrPTNLeX1xOebSfU/kola2A9yOsX/KVLL8U7v1/2odrA8kbZp0mTL
         yZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=f0A4GwmJar4RSXfu4McJKvNytWuXkPDHnCbe0gc3MQA=;
        b=JmlpClcj3GiVuCaT/NTe91WoPgokur/+MN3iu8U5V+ZB33hmgf8KK/+NaGukX9BkFU
         bH+ddcf3lpGbOsds2wejSuv8M3je2e2jNXsZshAh+h6CfSRczyCqHbk+F5mOSc/YEZYN
         skbyL6Gs0lgoP6TjTobjjN4MkDu8MQ0eQ0+Zu0v/tIoZJjFrUSpO8tGxSiHkRKJIojN0
         FvxQAyFkGeaNAmhan6XG5an+neua0LS0h0gjqiOnkxSnPsRJXABiy8HPlE2GokGlfKkO
         TdqBY1llITpvuDKQQGL3XGYyYkdLPS+LOxS/iS+I+0/3ZfPlv0/1x8v5qXgGauJFWofB
         Cbeg==
Received: by 10.180.88.199 with SMTP id bi7mr2935555wib.12.1331284926331;
        Fri, 09 Mar 2012 01:22:06 -0800 (PST)
Received: by 10.180.88.199 with SMTP id bi7mr2935537wib.12.1331284926247; Fri,
 09 Mar 2012 01:22:06 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Fri, 9 Mar 2012 01:21:46 -0800 (PST)
In-Reply-To: <CAJh6GrHMb-H6ktEGGHxMxbZXujKFe=unYzAyS-zoGnfzMfcKQA@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmzHxB7Efne8HO6ha0MkMSpYOwSnogktmDjZkMXLOvEg8R+ezBKOoQw1mSs5HRABeNZ0LZOk7HIAGSaRSRcTyiMNLY3jQg9xoijarrQtUD2xxJU0CZoCxgjCDQ6oN2pg9+lts/I73RLOmhkhJ/6xTiVpFzgyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192698>

On Fri, Mar 9, 2012 at 6:00 AM, David Barr <davidbarr@google.com> wrote=
:
>> I do notice however that the output being fed to sed expands like so=
:
>>
>> =A0commit >634a5f265ad729b91266de65272e2b5a35d05b1c
>> =A0>634a5f265ad729b91266de65272e2b5a35d05b1c 634a5f2 INSTALL: warn [=
=2E..]
>> =A0commit >828ea97de486c1693d6e4f2c7347acb50235a85d
>> =A0>828ea97de486c1693d6e4f2c7347acb50235a85d 828ea97 Git 1.7.9
>>
>> Maybe the format spec and sed command could use a little tuning.

Never mind, I missed the "and sed command" part and now I get what you
have in mind. This is a bit beyond my sed skillz at the moment but
I'll get back to you :)

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
