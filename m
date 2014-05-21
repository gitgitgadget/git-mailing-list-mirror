From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 15:12:21 -0700
Message-ID: <20140521221221.GC13956@hudson.localdomain>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
 <20140521215059.GB13956@hudson.localdomain>
 <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEkY-00066r-PC
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaEUWMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:12:32 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47662 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbaEUWM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:12:27 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1778611pdi.41
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JT9LnXHcWe9shszyBStK/ncoM0MqFVY4p8Aak0rUMkM=;
        b=q8OwoY6LJsy3b+lftIWF2HKMYVPXWuouP5vIxjkH5r3nS1+UUqAdsExm+lrxCr4Ppd
         eZmNXiH733VRn6M+cDIjcC6N0HG6IH1E6tCDyB+x7Zt62mMSdhY6Yjw+hX+cE1fFeEtZ
         1dDKDqvCA0IaUfJ2Yb7yTJjVs5Q5xyRFds5kKVkB0NkmzDjJOmwQXMuTa6TaLnr+S2+j
         GQOsOUI08lMWbISvq4BZWmq88iTAGUj0Mw0C77OrC6qe7acY5kVO6KOgpzyOqxeJb3GA
         O7j5XXcUZoAMH7SgK42D6JFjL+kTjhm9nwYgPexv9Mt/VKs+LddPMkok8ju1WIPnxqLK
         f81A==
X-Received: by 10.66.253.33 with SMTP id zx1mr62754042pac.28.1400710345456;
        Wed, 21 May 2014 15:12:25 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id ek2sm9726072pbd.30.2014.05.21.15.12.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 15:12:24 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 15:12:21 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249849>

On Wed, May 21, 2014 at 02:58:42PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
...
> The problem is a "cat" you added outside test_expect_*; the recent
> push is to have as little executable outside them, especially the
> "set-up" code to prepare for the real tests.
> 
> i.e. we have been trying to write new tests (and convert old ones)
> like this:
> 
>         test_expect_success 'I test such and such ' '
>                 cat >input-for-test <<-\EOF &&
>                 here comes input
>                 EOF
>                 git command-to-be-tested <input-for-test >actual &&
>                 cat >expected <<-\EOF &&
>                 here comes expected output
>                 EOF
>                 test_cmp expected actual
>         '
> 
> not like this:
> 
>         cat >input-for-test <<-\EOF &&
>         here comes input
>         EOF
>         test_expect_success 'I test such and such ' '
>                 git command-to-be-tested <input-for-test >actual &&
>                 cat >expected <<-\EOF &&
>                 here comes expected output
>                 EOF
>                 test_cmp expected actual
>         '

Now I understand.

Below is one of the updated test cases.

test_expect_success 'format-patch --signature-file=mail-signature' '
	cat >mail-signature <<-\EOF

	Test User <test.email@kernel.org>
	http://git.kernel.org/cgit/git/git.git

	git.kernel.org/?p=git/git.git;a=summary

	EOF
	git format-patch --stdout --signature-file=mail-signature -1 >output &&
	check_patch output &&
	sed -n -e "/^-- $/,\$p" <output | sed -e "1d" | sed -e "\$d" >output2 &&
	test_cmp mail-signature output2
'

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
