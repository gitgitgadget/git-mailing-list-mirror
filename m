From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: fatal: ambiguous message
Date: Sun, 02 Jan 2011 10:03:55 -0800
Message-ID: <4D20BE0B.6040104@gmail.com>
References: <4D1D33D7.7040809@gmail.com> <4D1DFF96.4010004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Cc: GNU Autoconf mailing list <autoconf@gnu.org>
To: Eric Blake <eblake@redhat.com>,
	GIT Development <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 02 19:04:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZSI0-0001v1-Er
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 19:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab1ABSEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 13:04:06 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46048 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab1ABSEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 13:04:04 -0500
Received: by pva4 with SMTP id 4so2356261pva.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AByoaZrMZwo1e45UUf4QRy6we1PDLAw0EjZVUyKrinY=;
        b=rkNC23mI+n5qwF8dfo6/p7pNr+jiTtyLV/1A62OBqc3fno0r4npKvhhzAoR2j7qAKj
         snibCummmGE5jVgQB6FBI2a9xI3l1XO/YM1Enn80AMbji/9CjSKzlnqx0Ao+6JPq8mY1
         aLdQ7YGGkpNHnWDDKAWUsgRLAESycyxyU0i38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HJtbV8sbOHGi8oCXvmjSn71YASxVqBIsh4Jnvd2CpX6x3aFh++y+7etJy+eNe4wTd1
         EckhMHaYYwRYv9U0DrMUDZiqME/j69ZLdsNkcOSqcAPm+7Tn0/40y4f9Z3yNpUAUOlMV
         pmh1GuRKcVY+bU0NEjAEM3MQtT4aYFc0kvuLc=
Received: by 10.142.203.1 with SMTP id a1mr16126083wfg.345.1293991443641;
        Sun, 02 Jan 2011 10:04:03 -0800 (PST)
Received: from [10.10.1.101] (adsl-75-2-133-184.dsl.pltn13.sbcglobal.net [75.2.133.184])
        by mx.google.com with ESMTPS id w14sm27950289wfd.18.2011.01.02.10.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 10:04:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <4D1DFF96.4010004@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164424>

On 12/31/10 08:06, Eric Blake wrote:
> On 12/30/2010 06:37 PM, Bruce Korb wrote:
>> Hi,
>>
>> Is this fatal?  If so, how come it continued?
> 
> It's fatal to git-version-gen, which did not continue.

git-version-gen has but two fatal conditions: invalid arguments
yielding a usage message and an unreadable "tarball version file".
That is not this message, but might be clarified with:

    v=`cat $tarball_version_file 2>&1` || {
        echo "$0 error: unreadable tarball version file $1:  $v" >&2
        exit 1
    }

In any event, the invocation is:
   ./git-version-gen .tarball-version
and the file ".tarball-version" does not exist, hence git-version-gen
should not fail at all.  So, this message says, "fatal: ..."
and comes from git and all three "git" invocations redirect stderr to
/dev/null.  The fact that we see it is a git bug.  Error messages
should be directed to stderr and thus written to /dev/null.

So, git-version-gen is correct to continue, but git should fail
with a message that names the program that fails ("git") and
should direct the message to stderr.

Note to GIT list: the message in question:

    fatal: ambiguous argument 'v0.1..HEAD': unknown revision \
       or path not in the working tree.

Thanks!  Regards, Bruce
