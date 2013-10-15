From: arnaud brejeon <arnaud.brejeon@gmail.com>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use it when provided instead of defaulting to end-user prompt
Date: Tue, 15 Oct 2013 19:07:12 +0200
Message-ID: <A605F10B-EAB3-4AC7-AB5A-4EFA1C505D4E@gmail.com>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com> <20131014141127.GA21200@google.com> <20131014184005.GA3352@dcvr.yhbt.net> <20131014223602.GB12116@sigill.intra.peff.net> <20131014233556.GA31230@dcvr.yhbt.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, matthijs@stdin.nl
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 19:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW85d-00084M-04
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 19:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303Ab3JORHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 13:07:19 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39398 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758936Ab3JORHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 13:07:18 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so3078868wid.15
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xtJn2afOzzDWz9UhscV5EwtqhYEMAGo/aKNLjf7KwEI=;
        b=WAikhCMRnixJauBFejDlyydNW2ijtEUZguw+YCRwA7sLeGJIji8+xz8QwbokWtd3vw
         u2vzgo6JesbmVnzUkz73LWfbcnhuea12ufzNa3/rCpsbdBSjcJDG8P4icH9kL0qyfbJ+
         O7j0zv814zwYCyY/Z3scRcaOSmq4/f4Ld8ySLaOIUUdtinPu1d02yo1OZk68F5oPZ2lt
         qg0q7jbTUxQAaOB1Ofy7/p97DPlccAQz8S8nbZDEQg5DWZ0K2DpkqX5t5rWlWFunhjF8
         PfUHELSlxj307BdzpUgpI5dWCCluveTr2AwDFDEEeUvRHH2JJK2oVe8urJXqmxP4d6kw
         Wctg==
X-Received: by 10.180.9.139 with SMTP id z11mr20542569wia.22.1381856836922;
        Tue, 15 Oct 2013 10:07:16 -0700 (PDT)
Received: from new-host-2.home (APuteaux-552-1-55-187.w90-35.abo.wanadoo.fr. [90.35.86.187])
        by mx.google.com with ESMTPSA id om10sm2461347wic.5.2013.10.15.10.07.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 10:07:15 -0700 (PDT)
In-Reply-To: <20131014233556.GA31230@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236189>


Le 15 oct. 2013 =E0 01:35, Eric Wong <normalperson@yhbt.net> a =E9crit =
:

> Jeff King <peff@peff.net> wrote:
>> On Mon, Oct 14, 2013 at 06:40:05PM +0000, Eric Wong wrote:
>>=20
>>>> arnaud.brejeon@gmail.com wrote:
>>>>=20
>>>>> Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
>>>>=20
>>>> Thanks.
>>>>=20
>>>> Can you say a little more about the context?  Do you run a script =
that
>>>> wants to pass a password to 'git svn', do you type it each time on=
 the
>>>> command line, or something else?  Is it ok that the password would
>>>> show up in "ps" output?  Would the platform's keyring or netrc be
>>>> usable here, or is there something in the context that avoids that=
?
>>>=20
>>> I think using keyring or netrc is more appropriate.  Having a passw=
ord
>>> on the command-line and visible to all via ps doesn't seem like
>>> something git should support.
>>=20
>> Agreed. We have ready-made git-credential helpers to handle this exa=
ct
>> problem. We would need to convert SVN::Prompt to use git-credential
>> rather than prompting itself, though. One of the things that held me
>> back from writing such a patch is that I thought libsvn already hand=
led
>> things like keychain integration, and it was better for git-svn to b=
e
>> more svn-like than git-like in its access of SVN repos.
>>=20
>> Are those already supported out of the box by libsvn? If git's
>> credential helpers are significantly more featureful, it might be wo=
rth
>> converting, but if not, I think it makes sense to stay with svn's
>> existing code.
>=20
> I looks like this patch was forgotten once again:
>=20
> http://mid.gmane.org/1371573490-21973-1-git-send-email-matthijs@stdin=
=2Enl
>=20
> Matthijs: can you add a Signed-off-by for your patch?  I'm inclined t=
o
> push it to Junio as-is since it looks reasonable.
> I admit I don't know SVN callbacks anymore well enough and don't have
> time to test with GNOME.

I wanted to provide some contexts, I should have done before.
I want to use git svn in some scripts that are launched un-attended. As=
 my SVN server requires a password, I need to provide it but it can not=
 be at user prompt.
This is why I wanted to add the password parameter that is available in=
 svn CLI.

I understand the concern regarding the fact that the password can be re=
trieved through ps.
You are right, it would be better to be able to use git-credential or l=
ibsvn solution for this purpose.

Arnaud
