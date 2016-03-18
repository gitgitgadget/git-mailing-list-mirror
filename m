From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 1/2] rebase: decouple --exec from --interactive
Date: Fri, 18 Mar 2016 14:46:19 -0700
Message-ID: <CAGZ79kb7_z4q+Q7TXG12Os5Pn-_5CYHx7ajdv3Ct8iQ59qAE=A@mail.gmail.com>
References: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
	<1458336377-28296-1-git-send-email-sbeller@google.com>
	<xmqqh9g3pj3e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2Dx-00079A-1J
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbcCRVqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:46:22 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38309 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbcCRVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:46:20 -0400
Received: by mail-ig0-f175.google.com with SMTP id ig19so31418432igb.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kFSyIy67jf/EF9DL3yBtKp3juIiO0IkaNnpWZj65FzU=;
        b=C7hoEVNKMQKXRCKDbxSbozs0Ib0Rleh7PK5HbPSW6Bp3SgD3pi5bV0kskGKdiEfw04
         PNTqJIFoEE4y0b3s4hBtQn5efzlgJAJk/TXgVcEHylYklpKSauiQVZ93XEzxo8vyyhzp
         mQSHzav/DmxlO7Lms2GlZnJrkBVc3T29WOBWfRpaSZpLm6t7a2ZdhZyZfTEH0qKmIzPZ
         g9UBvIU02fcHgLj4f2DlEnuD5VyGZiCZTXTN2pV84JX8XCzBgP6l4r8H320/6gSaD+Xz
         uYYtWLEDNUXSWqc2dp3sSKvwobAJUShGXLH1WM/cYVWmiPPhOOnmsTywDNCmmc1/wEN0
         NHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kFSyIy67jf/EF9DL3yBtKp3juIiO0IkaNnpWZj65FzU=;
        b=TgGmysTs6GBA8FRRPosvuoL+IUztI5ucZRUF2eWTl7bfSbAgdkN8v/ZcsMrHzG0Ml+
         wK4utjmXKyitqwAUY6YPl/FOg0EQ9u9RSfZBunSKXuvw7rf7yze5IejveqTsbiYOSIp3
         jiU53abhbSAjiPjLRbYPHZti7N8j2VCP9xvklRDxK1zJ2wZCdImBkkJNBjINDrGqhTdl
         0/bSJ5EW2v0j4QmdODHC7xNppFggxNrMvGugOIEu9oBP+HByRZZ5ksHGsKRRUrj/CMov
         NvQDdHn0g5V/0BW5FYKenc9kP1NbxJW7IJJbIEypFlZ4CtkGwqBf1idRUs422w+t2BuM
         j9JA==
X-Gm-Message-State: AD7BkJJTqxnBhIridVhbS0H6rPfJ58VIPEbJAVdmfIPA2Fw4vgvux+/NQmVg4SEyn2oA8c0WMgmW08LOmoRlSxsw
X-Received: by 10.50.13.37 with SMTP id e5mr1579769igc.85.1458337579800; Fri,
 18 Mar 2016 14:46:19 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 18 Mar 2016 14:46:19 -0700 (PDT)
In-Reply-To: <xmqqh9g3pj3e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289257>

On Fri, Mar 18, 2016 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * Diff to v2 in t3404:
>>         test_expect_success 'rebase --exec works without -i ' '
>>                 git reset --hard execute &&
>>                 rm -rf exec_output &&
>>         -     git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
>>         +     EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
>
> Hmph.  If you add "-i" to the command line, do you see the
> 'invoked_editor' file created?

just tested that by adding

    EDITOR="echo >invoked_editor" git rebase -i ...
    test_path_is_file invoked_editor

and it works. I have a patch here with s/EDITOR/EDITOR/,
which I can send out...... and your follow up email came in,
so I stop bothering about this patch until further reviews, ok?
