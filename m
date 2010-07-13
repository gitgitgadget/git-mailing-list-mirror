From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Tue, 13 Jul 2010 11:11:20 -0400
Message-ID: <AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Daniel F <nanotube@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 17:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYh8v-0000kk-ON
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 17:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab0GMPLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 11:11:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41056 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab0GMPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 11:11:21 -0400
Received: by iwn7 with SMTP id 7so5915545iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/1n4q0N2fF7KHkELHsblt+bcDMHrWf3/Q//vctgOI4g=;
        b=s7lXRPCEbNDyjU3ALo7vWj3sNSqC/VOxEWaRsVQMW3kp7+iuZpH2C9S4v/sWY2ayYj
         kaFb0FGtDJ9+L2Lerl3AZei9hIJB3ZaHFOhl9jnhqITSPQVlS2fHuXqMUGC7FFy5P75y
         dAQeZTx3clAQDh6yTlnhntLpDV2AyTleKxGCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dKHYU3CyPnMlXm39yj3sxQYXkWtkFBetF1BvLTJg22H58vdGq1AG908+hNqd3UCnsq
         gtqzXdsXaAJ4+zCX64yTss1c4ZCg75LG8q2D8dv/UnvdQccdDEV8MsTZTODXw/84gk5C
         KHrd+TySKCgfnjV+0nlPtoCYQFWz7kK0ZCXXo=
Received: by 10.231.183.200 with SMTP id ch8mr14049590ibb.124.1279033880945; 
	Tue, 13 Jul 2010 08:11:20 -0700 (PDT)
Received: by 10.231.178.152 with HTTP; Tue, 13 Jul 2010 08:11:20 -0700 (PDT)
In-Reply-To: <AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150902>

On Tue, Jul 13, 2010 at 10:54 AM, Daniel F <nanotube@gmail.com> wrote:
> Apparently, git-am fails when the username is just one word.

And is less than 3 characters.

> if i put a space between the b and the c, it works just fine.
>
> However... do you not think that it is still a bug? Is it not quite reasonable
> for a person to want to identify with just a nick, rather than a full
> first and last name?
>
> And more to the immediate point... is there any way i can get git am
> to do what i want? :)

This is happening due to the get_sane_name check in mailinfo.c. The
rules for a "sane" name are actually from Linus' original code. From
2744b23 (Start of early patch applicator tools for git., 2005-04-11):

+static char *sanity_check(char *name, char *email)
+{
+       int len = strlen(name);
+       if (len < 3 || len > 60)
+               return email;
+       if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
+               return email;
+       return name;
+}

You could add an option to mailinfo to disable the sanity check and
then plumb that option into its various callers.

j.
