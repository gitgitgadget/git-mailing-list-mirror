Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D2C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383110AbiD3QfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383118AbiD3QfI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 12:35:08 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563218355
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 09:31:45 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nkq0T-00027U-EN;
        Sat, 30 Apr 2022 17:31:42 +0100
Message-ID: <a47aa216-958a-f8a9-e9bb-be6d56c05f2d@iee.email>
Date:   Sat, 30 Apr 2022 17:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Setting up `send-email` for SSL, and then using GCM (Git
 Credential Manager)
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <10919180-85ea-2172-28df-b718cdbdf783@iee.email>
 <c5a5b7a6-33fe-2dc7-ab18-b9b22d59c2c8@iee.email>
 <CACBZZX6d4f3TZnytxXy5_62EVbUL7UObyhR7eR3ApsECeQ=6sA@mail.gmail.com>
 <2f8567f7-6d9c-e79b-9a05-7dd55cb40224@iee.email>
In-Reply-To: <2f8567f7-6d9c-e79b-9a05-7dd55cb40224@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A catch up email to report where I got to; some successes and some
remaining todos.
Details in-line with original query.

On 16/04/2022 16:14, Philip Oakley wrote:
> (added Git List back - should be non HTML now ;-)
>
> On 16/04/2022 15:49, Ævar Arnfjörð Bjarmason wrote:
>> I'm on mobile so sorry for the off list HTML, but
>> 1. No it doesn't have GCM integration.
> Thanks for clarifying that.
>
>> 2. Have you tried debugging with e.g. stunnel and leaving the
>> encryption out of git send email
> Sounds useful. I hadn't realised what 'stunnel' did beforehand.. 
> Hopefully it'll let me see how the server that hosts my domain is
> responding (or not).
> At the moment I'm doing my investigation from my win10 machine...
I didn't , in the end, use `stunnel`, but it looks like the right tool
for more detailed investigation.
>
>> 3. I find all things email so much less of a hassle by setting up a
>> local "open relay" exim or other real MTA on my laptop.
>>
> I suspect (hope) that once I've cracked the access method to the remote
> email server that I'll be able to set my gitconfig so that `send-email`
> will Just Work(tm), minus the GCM aspiration ;-)
Ended up using plain port 25 SMTP + pwd, which wasn't advertised as
available by my domain provider. Not the full solution but a start. At
least I now have a working `send-email` that is not locked to my home
ISP connection.
>
>> Maybe that helps, maybe not, it sidesteps your questions a bit, but
>> maybe in a way where you won't need to worry about git send email.
> It has been a help.
>
> Philip

While intermittently trying stuff, I was also able to get the `git
imap-send -v` settings to work (port 993). I did need to change the path
to my 'Drafts' mailbox (it's not below 'Inbox.' in my Thunderbird). Only
tested with `sslVerify = false`.

The `-v` did indicate that the GCM was being invoked, based on some
warning text but I haven't taken that further.
"warning: see https://aka.ms/gcm/autodetect for more information."
>
>> On Sat, Apr 16, 2022, 16:04 Philip Oakley <philipoakley@iee.email> wrote:
>>
>>     This maybe a wXYz-Problem. But I'm stuck at getting SSL to work with
>>     `send-email`.
>>
>>     I'm trying to update both my home Windows PC (win10) and my Ubuntu
>>     travel laptop (an old-Acer-i5) `send-email` setup/config to use my
>>     personal email domain (with authentication), rather than my old
>>     home ISP
>>     locked (no auth) connection, but I'm struggling.
>>
>>     Z) Does the GCM (Git Credential Manager) integrate well with
>>     send-email,
>>     and what guidance is available for setting up and debugging the
>>     `send-email` configuration?
Maybe should raise an issue with GCM on supporting send-email and imap-send?
>>     Y) It's not clear what I should see in the terminal window in either
>>     Git-for-Windows or Ubuntu when testing the `git send-email` command -
>>     without/with using GCM.
>>
>>     w) Some back story. I set up my existing telephone-line-locked home
>>     send-email config many years ago around the time of dial-up/ADSL. My
>>     router logs into my ISP giving me an open port 25 for SMTP (though
>>     doesn't advertise that any more). My config for the ISP is simple,
>>     needing only the `smtpServer, smtpServerPort`, and my `from,
>>     suppressfrom, & chainreplyto` settings. It works for both the Win
>>     PC and
>>     my Ubuntu laptop, but I can only use this when at home.
>>
>>     I also have a personal email domain (iee.email) whose authentication
>>     works with Thunderbird for the WinPC at home, and the Ubuntu laptop at
>>     home and when away from home.  I'd like to be able to use `
>>     send-email`
>>     via the personal email domain on the laptop when away from home (final
>>     goal), and also match that `send-email` use on the Win PC (which would
>>     also allow easy switching ISP when needed).
So port 25 to the rescue as noted. Sufficient to do work.
>>
>>     X) Where I've reached. I've discovered `sendemail.identity`, so at
>>     least
>>     I can have both configurations available for selection [7]. I've added
>>     the --smtp-debug=1` with little insight. I've hit a brick wall with
>>     respect to establishing the connection (I think). It's not clear
>>     if any
>>     authentication (password stuff) has started.
>>
>>     I fail to get the "<<<220 xxxxx   server ready" reply that my ISP
>>     identity gives, rather I get "Net::SMTP: Net::Cmd::getline():
>>     unexpected
>>     EOF on command channel: Connection reset by peer ... Unable to
>>     initialize SMTP properly. Check config and use --smtp-debug. VALUES:
>>     server=smtp.hosts.co.uk <http://smtp.hosts.co.uk> encryption=
>>     hello=localhost.localdomain port=465"
>>
>>     I've added below the terminal responses [1,3] and extracts of the
>>     config
>>     [2,4] for my test 'cover-letter'. Plus my Thunderbird settings [5] for
>>     comparison. Git build [6]. Domain provider advice [8].
>>
>>     Thoughts: Maybe the setting I need for `git-end-email` don't match
>>     those
>>     used by Thunderbird; Is there extra debug info if I set some extra
>>     parameters. Maybe some other tool can provide insight into what's
>>     failing?
>>
>>     Any suggestions?
>>     --
>>     Philip
>>
>>     [1] Failing case
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     (die_preserve_ggg)
>>     $ git send-email --identity=Names   --to="Philip Oakley
>>     <philipoakley@iee.email>" --smtp-debug=1  0000*.patch
>>     0000-cover-letter.patch
>>     Net::SMTP>>> Net::SMTP(3.13)
>>     Net::SMTP>>>   Net::Cmd(3.13)
>>     Net::SMTP>>>     Exporter(5.76)
>>     Net::SMTP>>>   IO::Socket::IP(0.41)
>>     Net::SMTP>>>     IO::Socket(1.46)
>>     Net::SMTP>>>       IO::Handle(1.46)
>>     Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:
>>     Connection reset by peer at C:/Program
>>     Files/Git/mingw64/libexec/git-core\git-send-email line 1698.

I've still to delve into that part of the code. I'm cautious of it being
a bit of a tar pit when other solutions may be simpler (e.g. continuing
with the port 25 solution).

The choice of implicit vs explicit ssl is still something I haven't
fully understood, though the explanation of the relationship between
methods at https://stackoverflow.com/a/29022120/717355 was useful. How
the implicit ssl is started is something I'm still unfamiliar with.
>>     Unable to initialize SMTP properly. Check config and use --smtp-debug.
>>     VALUES: server=smtp.hosts.co.uk <http://smtp.hosts.co.uk>
>>     encryption= hello=localhost.localdomain
>>     port=465 at C:/Program
>>     Files/Git/mingw64/libexec/git-core\git-send-email
>>     line 1725.
>>
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     (die_preserve_ggg)
>>
>>     ---
>>     [2]
>>     [sendemail "Names"]
>>         chainreplyto = false
>>         from = Philip Oakley <philipoakley@iee.email>
>>         suppressfrom = true
>>         smtpServer = smtp.hosts.co.uk <http://smtp.hosts.co.uk>
>>         smtpServerPort = 465
port 25 works here!
>>         smptEncryption = ssl
>>         smtpUser = iee.email
>>
>>         smtpPass = <password>
>>
>>     ----------------------
>>     [3] Existing (passing) case
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     (die_preserve_ggg)
>>     $ git send-email --identity=TalkTalk   --to="Philip Oakley
>>     <philipoakley@iee.email>" --smtp-debug=1  0000*.patch
>>     0000-cover-letter.patch
>>     Net::SMTP>>> Net::SMTP(3.13)
>>     Net::SMTP>>>   Net::Cmd(3.13)
>>     Net::SMTP>>>     Exporter(5.76)
>>     Net::SMTP>>>   IO::Socket::IP(0.41)
>>     Net::SMTP>>>     IO::Socket(1.46)
>>     Net::SMTP>>>       IO::Handle(1.46)
>>     Net::SMTP=GLOB(0x800c16240)<<< 220 cm4nec smtp.talktalk.net
>>     <http://smtp.talktalk.net> ESMTP server
>>     ready
>>     Net::SMTP=GLOB(0x800c16240)>>> EHLO localhost.localdomain
>>     Net::SMTP=GLOB(0x800c16240)<<< 250-cm4nec hello [84.13.159.41],
>>     pleased
>>     to meet you
>>     Net::SMTP=GLOB(0x800c16240)<<< 250-HELP
>>     Net::SMTP=GLOB(0x800c16240)<<< 250-SIZE 30000000
>>     Net::SMTP=GLOB(0x800c16240)<<< 250-ENHANCEDSTATUSCODES
>>     Net::SMTP=GLOB(0x800c16240)<<< 250-8BITMIME
>>     Net::SMTP=GLOB(0x800c16240)<<< 250 OK
>>     Net::SMTP=GLOB(0x800c16240)>>> MAIL FROM:<philipoakley@iee.email>
>>     Net::SMTP=GLOB(0x800c16240)<<< 250 2.1.0 <philipoakley@iee.email>
>>     sender ok
>>     Net::SMTP=GLOB(0x800c16240)>>> RCPT TO:<philipoakley@iee.email>
>>     Net::SMTP=GLOB(0x800c16240)<<< 250 2.1.5 <philipoakley@iee.email>
>>     recipient ok
>>     Net::SMTP=GLOB(0x800c16240)>>> DATA
>>     Net::SMTP=GLOB(0x800c16240)<<< 354 OK
>>     Net::SMTP=GLOB(0x800c16240)>>> From: Philip Oakley
>>     <philipoakley@iee.email>
>>     Net::SMTP=GLOB(0x800c16240)>>> To: Philip Oakley
>>     <philipoakley@iee.email>
>>     Net::SMTP=GLOB(0x800c16240)>>> Subject: [PATCH 0/1] *** Test Names ***
>>     Net::SMTP=GLOB(0x800c16240)>>> Date: Sat, 16 Apr 2022 09:54:00 +0100
>>     Net::SMTP=GLOB(0x800c16240)>>> Message-Id:
>>     <20220416085400.277-1-philipoakley@iee.email>
>>     Net::SMTP=GLOB(0x800c16240)>>> X-Mailer: git-send-email
>>     2.36.0.rc0.windows.1
>>     Net::SMTP=GLOB(0x800c16240)>>> MIME-Version: 1.0
>>     Net::SMTP=GLOB(0x800c16240)>>> Content-Transfer-Encoding: 8bit
>>     Net::SMTP=GLOB(0x800c16240)>>> *** Test BLURB  ***
>>     [...]
>>     Net::SMTP=GLOB(0x800c16240)>>> 2.36.0.rc0.windows.1
>>     Net::SMTP=GLOB(0x800c16240)>>> .
>>     Net::SMTP=GLOB(0x800c16240)<<< 250 2.0.0 feC1ntahZW5NofeC1ntcj4 mail
>>     accepted for delivery
>>     OK. Log says:
>>     Server: smtp.talktalk.net <http://smtp.talktalk.net>
>>     MAIL FROM:<philipoakley@iee.email>
>>     RCPT TO:<philipoakley@iee.email>
>>     From: Philip Oakley <philipoakley@iee.email>
>>     To: Philip Oakley <philipoakley@iee.email>
>>     Subject: [PATCH 0/1] *** Test Names ***
>>     Date: Sat, 16 Apr 2022 09:54:00 +0100
>>     Message-Id: <20220416085400.277-1-philipoakley@iee.email>
>>     X-Mailer: git-send-email 2.36.0.rc0.windows.1
>>     MIME-Version: 1.0
>>     Content-Transfer-Encoding: 8bit
>>
>>     Result: 250
>>     Net::SMTP=GLOB(0x800c16240)>>> QUIT
>>     Net::SMTP=GLOB(0x800c16240)<<< 221 2.0.0 cm4nec smtp.talktalk.net
>>     <http://smtp.talktalk.net>
>>     closing connection
>>
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     (die_preserve_ggg)
>>
>>     ---
>>     [4]
>>     [sendemail "TalkTalk"]
>>         chainreplyto = false
>>         from = Philip Oakley <philipoakley@iee.email>
>>         suppressfrom = true
>>         smtpServer = smtp.talktalk.net <http://smtp.talktalk.net>
>>         smtpServerPort = 25
>>
>>     [5] Thunderbird (IMAP) Server Settings (gui)
>>     ServerName: imap.hosts.co.uk <http://imap.hosts.co.uk>
>>     ServerPort: 993
>>     UserName: iee.email
>>     ConnectionSecurity: SSL/TLS    [None|StartTLS|Ssl/tls]
>>     AuthMethod: NormalPass     
>>     [Normal|Encrypted|Kerebos/Gssapi|NTLM|TLScert|Oath2]
>>     --
>>     Thunderbird Outgoing SMPTP Server
>>     smtp.hosts.co.uk <http://smtp.hosts.co.uk>
>>     465
>>     SSL/TLS
>>     NormalPassword
>>     iee.email
>>
>>     [6] Git Build details
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     $ git --version --build-options
>>     git version 2.36.0.rc0.windows.1
>>     cpu: x86_64
>>     built from commit: c61dcf9cfa725959a79a3fb61d63bc05cc13ac7a
>>     sizeof-long: 4
>>     sizeof-size_t: 8
>>     shell-path: /bin/sh
>>     feature: fsmonitor--daemon
>>
>>     phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git
>>     $ cat /etc/install-options.txt
>>     Editor Option: Notepad++
>>     Custom Editor Path:
>>     Default Branch Option: main
>>     Path Option: Cmd
>>     SSH Option: OpenSSH
>>     Tortoise Option: false
>>     CURL Option: OpenSSL
>>     CRLF Option: CRLFAlways
>>     Bash Terminal Option: MinTTY
>>     Git Pull Behavior Option: Merge
>>     Use Credential Manager: Enabled
>>     Performance Tweaks FSCache: Enabled
>>     Enable Symlinks: Disabled
>>     Enable Pseudo Console Support: Disabled
>>     Enable FSMonitor: Disabled
>>
>>     [7] sendemail.identity now comes straight after the new safe.directory
>>     entry - serendipity ..
>>
>>     [8] Names domain smtp advice
>>     https://www.names.co.uk/support/articles/sending-emails-via-alternate-smtp-ports/
>>     [Use SSL/465]
>>
>>
--
Philip
