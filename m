From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 2 Jun 2015 09:41:18 -0400
Message-ID: <CAPig+cQF6irJqYFZ=2YSevjF+ySUn25udYMKSg+VzXP0p0-eAw@mail.gmail.com>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
	<53678876.5326.1433230965582.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzmRZ-0004s6-0L
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbbFBNlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 09:41:21 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35670 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759162AbbFBNlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 09:41:19 -0400
Received: by iesa3 with SMTP id a3so133122509ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KlGXZmsC2s6NoKW0o9eN/cg8ooZBO+E7Wc/1Lk1G2cE=;
        b=l+LrPdQPRo5N/2v55EMbIzpU9KVG+HulToy1n/aPycwy+0XgcqkAGclBjnapwQ9li1
         7g3FZeHhKs/f2deUGmZHshW7rF/8ZhNJKNe7Ver4gL6MoKL/LLSammS5rb6yfzZFM+8I
         dv8iOzNFc6U3NtnPAUUx7y0n6lQbSzNjJB+F8XVWJYoIxy4VuXupZrsXzEJ3PtgotxCz
         1c3pYJriHcyJSvCdbM/tjZ0IKbjJP0OKe3KmjWlTeH6dfSw2m8StQKiVSJENsXO3pS0T
         dq0hEwPqh5fqMS7OMY6c6udEoVvCI6HFIczVUqfio3qJ8TYHo7Cf1GVLIM7lZAI9YSoB
         Pktg==
X-Received: by 10.50.118.42 with SMTP id kj10mr4486650igb.1.1433252478579;
 Tue, 02 Jun 2015 06:41:18 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 06:41:18 -0700 (PDT)
In-Reply-To: <53678876.5326.1433230965582.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: EMyPo3waWkMj5jf2Up4HIT95BOo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270533>

On Tue, Jun 2, 2015 at 3:42 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > +test_expect_success 'rebase -i respects rebase.checkLevel' '
>> > +       test_config rebase.checkLevel error &&
>> > +       test_when_finished "git checkout master" &&
>> > +       git checkout -b tmp2 master &&
>> > +       set_fake_editor &&
>> > +       test_must_fail env FAKE_LINES="1 2 3 4" git rebase -i --root &&
>> > +       test E = $(git cat-file commit HEAD | sed -ne \$p)
>> > +'
>>
>> Shouldn't you also explicitly test "warn" and "ignore" modes?
>
> I don't think testing "ignore" is really necessary since it
> corresponds to the default behaviour, it is thus silently tested by
> the other tests.

Although the underlying behavior of "ignore" may be the same as the
default, you also want to check that higher-level machinery for
recognizing the "ignore" option is working correctly, which is why
checking "ignore" explicitly is a reasonable thing to do.

> Either way, I will add a test for "warn".
