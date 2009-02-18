From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/3] git-gui: properly check for a bare repo
Date: Wed, 18 Feb 2009 22:47:02 +0100
Message-ID: <cb7bb73a0902181347k6ae479b4v84e2ea8a9f6639dc@mail.gmail.com>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1234144850-2903-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <20090218171639.GE22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuIB-0004wZ-Ex
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760198AbZBRVrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760196AbZBRVrI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:47:08 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62163 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760186AbZBRVrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:47:05 -0500
Received: by ewy14 with SMTP id 14so92592ewy.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=djjbPHactAGDn254R44pFFJ93vTsZgEzWamewZAYF1Q=;
        b=UlBtdxvnr26DxpOFETbbu+H32Vbc0vEWfPL1Xg5Q/rlr5+grNMUD+w4EEIVezRiKIs
         qBU+tEb/ZmGReNxmin4nUTDZv64vZYEqjdU0ymUU44VQ9NsSx5Uabl+qFn9OyFXbGEfA
         3rVAjzY+GtNbV4f5rz3c0oCI/Lk+93nzJHLis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vCgwh2kPapbOcYNfqXERt8YdtuO3Ke2FOC35BDV6qQtY1s1Fy0TVQaDJ0SeuTD8S9e
         M0bFBKAmeRHMw1Bi5vywzeyFJ50voDVaZvsCUmtCbi0iXVH6OAM7MTgict/cplHoPthc
         DU/4Gpn5JeoYc9CwR729TlrIwW5Z3bw06BWFY=
Received: by 10.210.120.7 with SMTP id s7mr2480582ebc.187.1234993622405; Wed, 
	18 Feb 2009 13:47:02 -0800 (PST)
In-Reply-To: <20090218171639.GE22848@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110581>

On Wed, Feb 18, 2009 at 6:16 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>> When bare repository handling is not enabled, check for a bare
>> repository looking at the core.bare config option rather than refusing
>> to operate with a git directory ending with .git.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> I know I should have probably used something like
>> git rev-parse --is-bare-repository instead, but I didn't feel like
>> adding another git call. Is the config approach robust enough?
>>
>>  git-gui/git-gui.sh |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index e018e07..658a728 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -1071,7 +1071,7 @@ if {$_prefix ne {}} {
>>       }
>>       unset cdup
>>  } elseif {![is_enabled bare]} {
>> -     if {[lindex [file split $_gitdir] end] ne {.git}} {
>> +     if {[is_config_true core.bare]} {
>
> This doesn't work as you expect.  Its a chicken-and-egg problem.
> We haven't read the config yet because we aren't sure that the
> $_gitdir really is a git directory.  Consequently, core.bare is
> always false.

Isn't the config loaded on line 1053?

Better ways to work around the issue?

-- 
Giuseppe "Oblomov" Bilotta
