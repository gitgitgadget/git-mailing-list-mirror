From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 12:23:33 -0700
Message-ID: <CAGZ79kZ-xf167LiO+zY+B8BTYd-9h7u=dgpL=4tsEJDPgwq8CA@mail.gmail.com>
References: <20160517031353.23707-1-sbeller@google.com> <20160517031353.23707-5-sbeller@google.com>
 <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 21:23:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2kak-0001qW-KE
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbcEQTXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:23:36 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36052 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcEQTXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:23:35 -0400
Received: by mail-io0-f179.google.com with SMTP id i75so36772683ioa.3
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YifqyAbvUTEciK2mtJS39v4+oTTk0vOOMfQFt3aGuYo=;
        b=UvZYqY0Art8ISYwbYOXidCx4+sSaLzWBnqWRf4yc0vhMcoKja56vXtwLRWpSAwHMoL
         odhx3MlCosSpJv+47vSJUOm872EXjqWMzSvmuXHDRibF6RCtSgv+AkZNiHTMY1mMfa5h
         QI9gRuPsOPA2X1+Hps0q0Kb8h7+HFv8y3hrNtKT6YVxRmHMEr+iZyBtwD5Di+UaLJXL8
         vxg8jBd/4x6mU/00Y+Tr+tSLn58/YZts1IdkQkEadKnMvhFx9MFmtztZguwaz2F/UOoe
         5h6fxff4HaIuazvNCuUH8T6rtktbepiwxhfXvi9u/xmSmZewh7y7RtuhBEXh9n4d6xdX
         Hn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YifqyAbvUTEciK2mtJS39v4+oTTk0vOOMfQFt3aGuYo=;
        b=MYRgCEuVSHyRmn0IbIqGoy5G3RcqxXlL1uuMRYfXx0Iymhm3sFfVMOcR4WYtv2lZAy
         Po6SgFyh1LjaWpJWNS1yQea3pIXn9/IvDbAnLX+Zi/jcZeSyDfymEOvMJMyLv+hzn0mA
         PNo83kTqQHI4pHAXEnfYxmra666I05aqN+IvEcbkD0I+oTrbHSF+1ILtCqKbS34T8xyo
         7haoKuLjKOT35t/KoQN2v0hHO6vNIYoZsSmruB1VQoXnNaefLYSlqXr55mV6K8IQyoze
         9AzYrt8pu43jo5Kxm4dcK2G1ybhnJTYYLLC3DRhTiQQyifUSLAuTAnT/TXvlUdR8a7D/
         U7NA==
X-Gm-Message-State: AOPr4FVmUVkRs7FrN5Hk9CJfFZRgm6YEHy14nOXspeFP1dIB20tNJ+qXCtnWCu8O+vBIpgFBoz8wJ0sjKL64FoOe
X-Received: by 10.107.53.204 with SMTP id k73mr2322584ioo.174.1463513014317;
 Tue, 17 May 2016 12:23:34 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 12:23:33 -0700 (PDT)
In-Reply-To: <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294898>

On Mon, May 16, 2016 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When matching (i.e. the match_attrs() function), you would instead
> do
>
>         path = xmemdupz(name, namelen);
>         git_check_attr(path, item->attr_check);
>
> to grab values for only attributes that matter to you, instead of
> calling git_all_attrs() [*2*].
>
> After git_check_attr() returns, item->attr_check.check[0].attr would
> be git_attr("VAR1") and item->attr_check.check[0].value would be
> whatever setting the path has for the VAR1 attribute.  You can use
> your match_mode logic to compare it with the values .attr_match
> expects.
>
> You do not necessarily have to have the same number of elements in
> .attr_match and .attr_check.check by the way.  .attr_match might say
>
>         VAR1=VAL2 !VAR1 -VAR1
>
> which may be always false if these are ANDed together, but in order
> to evaluate it, you need only one git_attr_check_elem for VAR1.

So for the matching we would need to get the order right, i.e.

    const char *inspect_name = git_attr_name(item.attr_match[i].attr);
    for (j=0; j <  p.attr_check.check_nr; j++) {
        const char *cur_name = git_attr_name(p.attr_check.check[j].attr);
        if (!strcmp(inspect_name, cur_name))
            break;
    // now compare .attr_match[i] with attr_check.check[j]

This doesn't look cheap to me? Am I holding it wrong again?
