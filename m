From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Tue, 23 Jun 2015 22:15:07 +0200 (CEST)
Message-ID: <69022894.748633.1435090507744.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1692637261.3463890.1434881256090.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UZH-0007Bq-1o
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbbFWUNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:13:11 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:50819 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932747AbbFWUNK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:13:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D2B8D2945;
	Tue, 23 Jun 2015 22:13:08 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H67OYDw4XcEe; Tue, 23 Jun 2015 22:13:08 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BEF1E2941;
	Tue, 23 Jun 2015 22:13:08 +0200 (CEST)
In-Reply-To: <1692637261.3463890.1434881256090.JavaMail.zimbra@imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: +M3vEpJoD3pi1fRp2/fC1zqK+r+ZxYwFCXZ1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272493>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> > We can redirect todo_output to a variable but I've not found better...
> > (Maybe someone has the solution here ?). Also there's no summary at
> > the end of the test (as with other perl tests).
> 
> You can get the 1..44 at the end with
> 
> printf "1..%d\n", Test::More->builder->current_test;
> 
> This is what t9700/test.pl does.

I can also get it by removing the line 

 Test::More->builder->no_ending(1);

and replacing

 use Test::More;

by

 use Test::More "no_plan";

I think I'm going to do that, because the no_ending thing makes the
test suite success even if every test fails: at the end we have

# test_external test Perl address parsing function was ok
# test_external_without_stderr test no stderr: Perl address parsing function was ok

in case everything is ok. With the "no_ending" line, only the second
line reports failures, the first is always the same.
I think both must be marked red.
