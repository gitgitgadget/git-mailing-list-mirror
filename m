From: Eric Scouten <eric@scouten.com>
Subject: Re: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 21 Feb 2012 09:59:35 -0800
Message-ID: <CAEe=O8pnYF1Zxh33Wkm7LfFWGZwDLNRRCDdPYJ1QWjgR8OR+7w@mail.gmail.com>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
	<1329258835-17223-2-git-send-email-luke@diamand.org>
	<20120221121834.GB18317@padd.com>
	<CAEe=O8qui8PryuZiZNDwLk39+tKVDnh+5eP9m_WrHi=K9ekMNQ@mail.gmail.com>
	<7vobssgkt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 18:59:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzu0C-0006ku-1a
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 18:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab2BUR7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 12:59:37 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37573 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754515Ab2BUR7f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 12:59:35 -0500
Received: by obcva7 with SMTP id va7so8837511obc.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 09:59:35 -0800 (PST)
Received-SPF: pass (google.com: domain of eric.scouten@gmail.com designates 10.60.22.40 as permitted sender) client-ip=10.60.22.40;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of eric.scouten@gmail.com designates 10.60.22.40 as permitted sender) smtp.mail=eric.scouten@gmail.com; dkim=pass header.i=eric.scouten@gmail.com
Received: from mr.google.com ([10.60.22.40])
        by 10.60.22.40 with SMTP id a8mr12486395oef.59.1329847175230 (num_hops = 1);
        Tue, 21 Feb 2012 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JqlfRusz6OARVuSkLaMHC10vJBxbuRj8J7VdLfJuqjo=;
        b=S+DWuZ6ItxarqIb9ObnFtVGq9WVKwyX3XynutmXyWndv/iWUXpLUaD8QrrjNVmlgB8
         85FeN3S+Tm3cSSAm0GzCZx3gdawgI46qN6UXJwC+TERuPg037yRDTmyOr6w46Ore2syG
         sgZpEnFbwiFQUd+i2k2ySE+bCbK5jSphLXuks=
Received: by 10.60.22.40 with SMTP id a8mr10680140oef.59.1329847175168; Tue,
 21 Feb 2012 09:59:35 -0800 (PST)
Received: by 10.182.61.135 with HTTP; Tue, 21 Feb 2012 09:59:35 -0800 (PST)
In-Reply-To: <7vobssgkt6.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: a68MrHIZZ8XUzCp_tlr90uXxwDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191172>

On Tue, Feb 21, 2012 at 09:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> Eric Scouten <eric@scouten.com> writes:
>
>>> > r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$'
>>>
>>> Still no ":"? =A0Won't that match too much?
>>
>>> Fix the colon thing at least, then happy to add my Acked-By.
>>
>> No, that would be an incorrect change. The colon is added by P4 when
>> it expands the keyword pattern, but it is *not* part of the pattern
>> required by P4 to trigger a keyword expansion.
>>
>> http://kb.perforce.com/article/54/using-rcs-keywords
>
> I have this suspicion that both Pete and your last sentence is correc=
t,
> but the regexp in the patch and your "would be an incorrect change" a=
re
> wrong.
>
> I am not a P4 expert, but I would be very surprised if P4 expands "$I=
da$"
> as if it is "$Id$" or "$Id: old expansion$", which the regexp would m=
atch.
>
> Wouldn't it be more like this?
>
> =A0 =A0 =A0 =A0\$ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# begins=
 with a dollar, followed by...
> =A0 =A0 =A0 =A0( Id | Header | ... ) =A0 # one of these keywords, fol=
lowed by ...
> =A0 =A0 =A0 =A0( :[^$]+ )? =A0 =A0 =A0 =A0 =A0 =A0 # possibly an old =
expansion, followed by
> =A0 =A0 =A0 =A0\$ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# anothe=
r dollar sign

Good catch. Yes, you're probably right.

--=20
Eric Scouten :: software developer, photographer :: Poulsbo, WA (near S=
eattle)
http://ericscouten.com :: click for Flickr, Facebook, Twitter, LinkedIn=
 links
