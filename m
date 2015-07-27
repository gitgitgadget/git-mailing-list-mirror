From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 27 Jul 2015 13:17:40 -0700
Message-ID: <xmqqegjticd7.fsf@gitster.dls.corp.google.com>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
	<87twspe6ix.fsf@marcos.anarc.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@koumbit.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 22:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJoqL-0003PP-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 22:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbbG0URp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2015 16:17:45 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36742 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbG0URo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 16:17:44 -0400
Received: by pdjr16 with SMTP id r16so58366179pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=2fvloNDq7U3fPzhPIw43f9LVc1JRNHSa2BcQXMEgWOc=;
        b=CXjGRq6bmeEfpU8aO6/53BCsJ4TW0KVm/Hz+UBS2/eJCkqMRmtrq2gfoVZDKqcwTtD
         tpL94DQ3jHre8jVXwPV04R++DZE30UEpLleun7nsauLKJEVrlZyIs1YnD1ge7VwhBgEq
         Q6P+GRuFOgjmz8nniFM7Lhw6SBIB2dkWn1TaBDVtdaK4KsbmSaA8GYdFRrpDjO9ZO7rF
         YOFe4W37jl7op/gEM1pNp05b2TVo2Cmar6fX/GirMlXJg7l3+iaTWfgZwGzU73LWaTC9
         4Wv8qOMuj3rgu+ZGPT+DYIL5yuN3l4BiQcKmyIz31ntLs1gW+ihAORoneo9Gx5fPc3iQ
         GUqA==
X-Received: by 10.70.103.8 with SMTP id fs8mr72245540pdb.97.1438028264254;
        Mon, 27 Jul 2015 13:17:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id yd8sm20842701pab.46.2015.07.27.13.17.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 13:17:42 -0700 (PDT)
In-Reply-To: <87twspe6ix.fsf@marcos.anarc.at> ("Antoine =?utf-8?Q?Beaupr?=
 =?utf-8?Q?=C3=A9=22's?= message of
	"Mon, 27 Jul 2015 15:37:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274708>

Antoine Beaupr=C3=A9 <anarcat@koumbit.org> writes:

> Any reason why this patch wasn't included / reviewed?
> ...
>> This patch is similar than the one provided by Milton Soares Filho i=
n
>> 1382734287.31768.1.git.send.email.milton.soares.filho@gmail.com but =
was
>> implemented independently and uses the 'o' character instead of 'x'.

The reason why Milton's patch was not taken after discussion [*1*]
was not because its implementation was poor, but its design was not
good.  By overriding '*' '<' or '>' with x, it made it impossible to
distinguish a root on the left side branch and a root on the right
side branch.

Is the design of your independent implementation the same except
that 'o' is used instead of 'x'?  Independent implementation does
not make the same design magically better, if that is the case ;-)

If the design is different, please explain how your patch solves the
issue with Milton's design in your log message.

=46or example, you could use the column arrangement to solve it, e.g.

History sequence A: a1 -- a2 -- a3 (root-commit)
History sequence B: b1 -- b2 -- b3 (root-commit)

    $ git log --graph --oneline A B
    * a1
    * a2
    * a3
      * b1
      * b2
      * b3

    $ git log --graph --oneline --left-right A...B
    < a1
    < a2
    < a3
      > b1
      > b2
      > b3

I am not saying that the above would be the only way to do so; there
may be other ways to solve the issue.

[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/236708/focus=
=3D236843
