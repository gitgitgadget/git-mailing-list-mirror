From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sat, 13 Feb 2010 15:16:52 +0100
Message-ID: <40aa078e1002130616u478397c0xf757d5424630e6cf@mail.gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
	 <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
	 <20100213122532.GA31653@dcvr.yhbt.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	"johannes.schindelin" <johannes.schindelin@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 15:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIoY-0003uS-MO
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab0BMOQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 09:16:54 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:43176 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0BMOQx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 09:16:53 -0500
Received: by ewy28 with SMTP id 28so2558237ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FC0BYvzL21A7JMR3LXSgIxugNB8zNybolY5m+z5/FXk=;
        b=OomRIyW5gjNLBILPALoQLGUMhge7WCphWtT6g+GjkFRhi9MEq+ZLAJ8vdHqWGDVwgr
         OD5uJOD6Znm0XB/7qI5g28OH1XdRddf4ooLnoln1MfsdhHVFxsQTwRQimgYR4r5OpeWL
         c/cS0TXGvZJ2V4KRO5IwNSCGZDQOMZlxxVI0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=ieZjgy1FMK0kuHANVhiLfWa2AitjjuoKgNkQjqagTyCLH44//nTOhEonJy6NX8/a89
         Vq+mn9glUBW0mY5ySeZc7ytI1grjJnSGyFm9WEF+3FXId5c6E5iZYIDi3rOTotLBc4wc
         bNQkfuRd1oSlV7Zb1u60SRH3NRnG1EIWqooQE=
Received: by 10.216.85.138 with SMTP id u10mr1695360wee.185.1266070612111; 
	Sat, 13 Feb 2010 06:16:52 -0800 (PST)
In-Reply-To: <20100213122532.GA31653@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139796>

On Sat, Feb 13, 2010 at 1:25 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> If I enable core.autocrlf and perform a "git svn rebase" that fetche=
s
>> a change containing CRLFs, the git-svn meta-data gets corrupted.
>>
>> Commit d3c9634e worked around this by setting core.autocrlf to "fals=
e"
>> in the per-repo config when initing the clone. However if the config
>> variable was changed, the breakage would still occur. This made it
>> painful to work with git-svn on repos with mostly checked in LFs on
>> Windows.
>>
>> This patch tries to fix the same problem while allowing core.autocrl=
f
>> to be enabled, by disabling filters when when hashing.
>>
>> git-svn is currently the only call-site for hash_and_insert_object
>> (apart from the test-suite), so changing it should be safe.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> With this patch applied, I guess we can also revert d3c9634e. I didn=
't
>> do this in this series, because I'm lazy and selfish and thus only
>> changed the code I needed to get what I wanted to work ;)
>>
>> I've been running git-svn with these patches with core.autocrlf enab=
led
>> since December, and never seen the breakage that I saw before d3c963=
4e.
>
> Hi Erik,
>
> How does reverting d3c9634e affect dcommit? =A0I've never dealt with =
(or
> even looked at) autocrlf, so I'll put my trust in you and Dscho with
> anything related to it.
>

I don't think it affects svn dcommit in any way, except from the
implicit svn rebase that svn dcommit performs. d3c9634e sets
core.autocrlf to "false" on init, but re-enabling it hasn't shown any
problems in my end. I'm using git-svn with these patches and
core.autocrlf enabled every day at my day-job.

I'd say that reverting d3c9634e would be the Right Thing To Do(tm),
because it makes git svn clone work just as bad as git clone, when
cloning a repo with CRLFs in it ;)

--=20
Erik "kusma" Faye-Lund
