From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Thu, 28 May 2015 15:18:28 -0400
Message-ID: <CAPig+cTdVZKrGM+8eSopCkUYxK08WB3ZriFOcbd+8Zkf2Y27nA@mail.gmail.com>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CAPig+cQ_PrY8=-iP-FJm_HZ+XKOVoc4NfDu6rtuBj8zfM5oG+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 21:18:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3K6-0003iQ-3w
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbbE1TSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:18:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36779 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbE1TS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:18:28 -0400
Received: by iepj10 with SMTP id j10so46054812iep.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EMkemMulbLGdXH7p7nCMeim28d7KBHCIg+fITUyijDQ=;
        b=kU6vQEgdGiorIgPEbOe0JZe3HCv4qewT6igtFJ1DZkmdeIilF00i6hsxVWPICXa6FL
         qViRHFsoeFXCRoEQEKKbTBnL9wpXbnhQCECyksyAc9yUFwS1DDOQdhNJY4xCko2fRhs3
         eli7noppQT8L1MOLxCiai8Lftjf8mt84mGckZUoBW9MreV+Pc6Ng+UNvW2qIBOgqUrQ6
         +FZnxrGH3bYPz6Uyg3GUGF8lOmO18T6xqKV8ycxGa6iR5X8vBySdFVyvkvLydYuXB+ar
         Yn1pgo3qMfuJrFC1MxQAyYllta1RHcmR0gkoP6pDbv1ZICSesBWcKzBbNlBHoz34hDS2
         CxQA==
X-Received: by 10.42.146.202 with SMTP id k10mr11207992icv.34.1432840708096;
 Thu, 28 May 2015 12:18:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 12:18:28 -0700 (PDT)
In-Reply-To: <CAPig+cQ_PrY8=-iP-FJm_HZ+XKOVoc4NfDu6rtuBj8zfM5oG+w@mail.gmail.com>
X-Google-Sender-Auth: 2-3X003J1K16qEScBMnYbcnjcqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270181>

On Thu, May 28, 2015 at 3:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 26, 2015 at 5:32 PM, Remi Lespinet
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>> +setup_temporary_branch () {
>> +       tmp_name=${2-"temporary"}

I forgot to mention the broken &&-chain here. Although the missing &&
doesn't actively hurt the function today, someone may someday insert
code above the 'tmp_name=' line without noticing the lack of &&, and
the test won't notice a failure in that newly added code. Thus, it's
better to keep the &&-chain intact throughout.

>> +       git reset --hard &&
>> +       rm -fr .git/rebase-apply &&
>> +       test_when_finished "git checkout $1 && git branch -D $tmp_name" &&
>> +       git checkout -b "$tmp_name" "$1"
>> +}
