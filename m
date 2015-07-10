From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Combined diff with name-only option
Date: Fri, 10 Jul 2015 10:47:46 -0700
Message-ID: <xmqq7fq7lxa5.fsf@gitster.dls.corp.google.com>
References: <559FA0EF.2000409@biu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Janusz =?utf-8?Q?Bia=C5=82obrzewski?= 
	<Janusz.Bialobrzewski@biu.pl>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDcSC-00066g-EP
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 19:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbbGJRvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2015 13:51:11 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38402 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933415AbbGJRrv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 13:47:51 -0400
Received: by igrv9 with SMTP id v9so18271026igr.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=s7BfSX7ODeq0qw42AkjBh6hJW8g878q14W09HQr/Y6I=;
        b=qYbQA4ohZQipHV5hEhC0U+n8w8ixsa+GCI0Y/1mvsCeXlDqIhmFjJkk/P2rU94/HMs
         apIlpvBHl49uK+WOtDcETXq+/NBmKijGYyUFOAXf4ROHR4r3ObwJJnPBxUo9p2+wBvyF
         95PcnEyCENJPppj+aPfTiTYo4N1e46LD9bTFIz0QfGu+Sf+3UK/5I9CC8YLqoAbeJ3dx
         AqrrDSiOjSHWwNSENotjD6eWY/PZZtw4DbSRiuKlfAQOJPNMjdBI4PaJ/gkXNqnznFnR
         Cx7V3tGSDlIDsrcD23r2CdILVrDi5xHEUxhW5Vm8x10v7n1I+Hip8Flzq+R7PhL2uOin
         y0Dw==
X-Received: by 10.50.225.103 with SMTP id rj7mr4607478igc.59.1436550469621;
        Fri, 10 Jul 2015 10:47:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id rs4sm12050igb.13.2015.07.10.10.47.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 10:47:48 -0700 (PDT)
In-Reply-To: <559FA0EF.2000409@biu.pl> ("Janusz =?utf-8?Q?Bia=C5=82obrzews?=
 =?utf-8?Q?ki=22's?= message of
	"Fri, 10 Jul 2015 12:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273827>

Janusz Bia=C5=82obrzewski  <Janusz.Bialobrzewski@biu.pl> writes:

> Is it a bug or is it done by design?

I suspect the answer is "no and not really".  The truth would be
closer to: we didn't bother to write code in the command line parser
to check and flag it as an error when "--cc" and "--name-only" is
given together.

Unlike "-c" that works solely on the tree level changes, "--cc"
looks into blob contents involved in the merge, but things like
"--name-status", etc., do not work at blob levels (you can consider
that part is "by design").

Similarly, if you make a whitespace-only change to a file and use

    git diff-tree -b -p

you will still see the name of the commit object, but no patch.

    git diff-tree -b --name-only

still reports the modified paths as tree-level differences.
