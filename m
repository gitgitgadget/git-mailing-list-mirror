From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 04:10:08 -0500
Message-ID: <CAPig+cQEfGj8dH+FFOR4UYbNgovhFy_pP8szSpS+0MyNdOvJrw@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
	<CAPig+cQEO+LKZJDzE-sUmo+td=djsOdjx-ouQEMRTTkOBMwzjA@mail.gmail.com>
	<CAGZ79kYvv_r8TahfoE5g_5nBQhjsAC3tHvxUUBE4PtKLy8sGhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 10:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sok-00082m-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 10:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbaL3JKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 04:10:11 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:57960 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaL3JKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 04:10:09 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so6942434ykp.39
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 01:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3E2dI4PDUmfLEV5nU+GZd4TmN4cPf7jtawfvojRaCFM=;
        b=Ps8wLLDFm9X2hHQziYGHZAlsazZJtiboMaotz8JVVabPsPlxjZ8IZ7o7mWMz57b+va
         PBXopo3EQgEDVhQRy8gEMhXddkJyTd5mivoZ1+XrEwU1i4xE9YU9aFOEZzQhwe8ppDV4
         hricJ78KTd0VAx+5qeoe+UVMOeScqYnnsjIrmcdPzoU+CFwUv2WroTUtH09aOlPUpf4S
         Pw3RCksPoXYYLZ6nphhulaG5l99jKlQ0ZgsDfjjJJJpcWY7ttIJZJ2EZ5d2BkBPh3jWp
         vaX9A8OeibCJ/r1bd4yrdD/LPlNtIGX11Ax/7HTmCrGAHgRlm1LHgWCVpjAMOdOIrN7M
         7dnw==
X-Received: by 10.236.89.172 with SMTP id c32mr40961725yhf.180.1419930608870;
 Tue, 30 Dec 2014 01:10:08 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 30 Dec 2014 01:10:08 -0800 (PST)
In-Reply-To: <CAGZ79kYvv_r8TahfoE5g_5nBQhjsAC3tHvxUUBE4PtKLy8sGhQ@mail.gmail.com>
X-Google-Sender-Auth: BJMyy_6Nc67UD5MVV5ppsOapqM0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261921>

On Tue, Dec 30, 2014 at 3:42 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Dec 29, 2014 at 11:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>>> No functional changes intended.
>>> +static void check_shallow_bugs(struct command *commands,
>>> +                              struct shallow_info *si)
>>> +{
>>> +       struct command *cmd;
>>> +       int checked_connectivity = 1;
>>> +       for (cmd = commands; cmd; cmd = cmd->next) {
>>> +               if (!should_process_cmd(cmd))
>>> +                       continue;
>>> +
>>> +               if (shallow_update && si->shallow_ref[cmd->index]) {
>>
>> Another issue: In the original code, 'si->shallow_ref[cmd->index]' is
>> only checked if cmd->error_string is NULL, but here you check it
>> unconditionally, despite the commit message claiming no functional
>> changes. Did you verify that such a behavioral change is benign? (This
>> is a genuine question.)
>
> The error != NULL check is done in if (!should_process_cmd(cmd))

Right. Thanks for setting me straight on that.
