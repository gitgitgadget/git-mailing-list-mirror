From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 8 Mar 2012 12:41:57 +0100
Message-ID: <CAJh6GrGcr3nOMR7Yrq7g8c-RgQ4FS_FrhcMb+w-nXQO2nic_rw@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <4F589611.6060106@viscovery.net> <CAJh6GrGch9JHYnGW+K-wxdX9wPRry4Lxi2ysTtt0g9FTF4ThTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:42:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bjk-0004kk-0R
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab2CHLmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:42:19 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57912 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370Ab2CHLmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:42:18 -0500
Received: by wejx9 with SMTP id x9so246424wej.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=LGe0xMhg+Xy2IMXuwnZ2hK9UPPgjFXn8XZ2RfW3yWhk=;
        b=LDl1GYPqoySAX5rj5dQE4iDzRN93bUNcm8rnZNQqTdhW7+e7BjbcwdUrTPMLdQe0bE
         5Ch3AsXBhbp5hsUKeC0aU9nHRZsiY42IZP6eeCrepFsxs5DTVvSyAJLpOkjtnUyaKrd0
         nv0ViJP3TiNOxpx9qKVW589imW3hza2ngoNwb4Beu+Y69v+r4WEe5uf957C7Xem9e6SN
         oKDuPXnWjsFPq+OvJLYgEq1Y3WjjLXNuuXvUc/5ONc+lDEcELrUQAh5isQbsr9d1aJ0l
         zQXuQRknlKl82XMucPi71eSDlS+iOtHMtx0NIDs8+QZEBCKlkkfXIfbYhMeZariyxvHh
         Fy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=LGe0xMhg+Xy2IMXuwnZ2hK9UPPgjFXn8XZ2RfW3yWhk=;
        b=mWXjSfCYTjc2lATgJZvQP8HU0p0VGFcNEmMOepVFjUhxru46HNzoFbBDUXYC2eJemg
         CokqRccSo0cJmogOo8d6i//ktMB7/tr2tg+wuB8A3lw9SbVMF1w6U/Vbido0b2SqS/Op
         0UVoVXRjUaz50Y6JOTBF+/MPfjFwPpI3jGDPom03QhpwvQvoeA+DpfnMDhiVZGCMXH9B
         b5vF2Sec+lSMl4e/OwAbT6c5xuobtuzpVEtfGbxq2RkHkkOQNRclNsNlLhrVMfTf+6cD
         np1zEsxjSaQncIWh0hYvXRbPBLBy6usjmLKfGOZwWOrF5eZ4XMYCCEPr/W7z42aCsGZy
         tXww==
Received: by 10.216.82.141 with SMTP id o13mr3119344wee.2.1331206937405;
        Thu, 08 Mar 2012 03:42:17 -0800 (PST)
Received: by 10.216.82.141 with SMTP id o13mr3119332wee.2.1331206937247; Thu,
 08 Mar 2012 03:42:17 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Thu, 8 Mar 2012 03:41:57 -0800 (PST)
In-Reply-To: <CAJh6GrGch9JHYnGW+K-wxdX9wPRry4Lxi2ysTtt0g9FTF4ThTQ@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlsTpGNBh6F+oGA4BblH3Obi9oWyAoO+niOaUHXx+4OEaR9k4vmkRbEwjhZtwh0DsREI3YGx1OP6fc/H3O1DJItNQYhUS0wIPWGS/rZVqd+MG7lpQDlMpw4iFEj762H5JE0job5sLvWPx1sDClixWwJVllyLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192571>

On Thu, Mar 8, 2012 at 12:36 PM, Dominique Quatravaux <domq@google.com>=
 wrote:
> On Thu, Mar 8, 2012 at 12:20 PM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>> Am 3/8/2012 11:42, schrieb Dominique Quatravaux:
>>> + =A0 =A0 shortsha1=3D$(echo $sha1 | cut -c1-7)
>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 sha1=3D$(git rev-parse $shortsha1)
>>
>> Why do you call it "optimization" when you spend two or three subpro=
cesses
>> instead of one?
>
> echo is a shell internal. "git rev-parse" is two processes just as
> "cut" and a pipe.

My mistake, strace git rev-parse revals that this is only one process.
Still, I think that saving a bunch of filesystem access beats saving
one fork() (one of the two processes in my patched version is a shell,
so no execve() there) but I admit I haven't benchmarked this.


--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
