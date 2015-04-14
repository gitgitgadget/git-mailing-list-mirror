From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Tue, 14 Apr 2015 15:28:14 -0700
Message-ID: <CAGZ79kaO_1QMMTY0ni9k3hrkrt_PhqRDRzXkhZEiYuJ0EsE9Tw@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<xmqqzj6a1m3c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9Jc-0005OU-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbbDNW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:28:17 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35589 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbDNW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:28:15 -0400
Received: by labbd9 with SMTP id bd9so19540226lab.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rvo2EnbYZrSMFa4jx6EWs+htq6fmSf2FeAX42zd2/q8=;
        b=TOMirWGsNxj/X1K0O1NJLTchyZK0Gt6XHp12tnU14ZOI5uoKUl++jv27V2N4wXcas4
         KMe0R1a8iQUxOtkRzU4vqq6BPhXOlPTtmwbvrwZhXMjw7nBYlhQCt0fcEV6kv155MfdX
         LTrSS7Ktt7HUmAJfyixSb6XwGuzuHC0rIXZ+sY3tjdcsbuPIFdb349QunEP3bWm9rxBn
         Y3pvGtU6a9LXRIme4NmcODZb/lieQ/ZX3+d6IzZpAbXC4d//N2XEhHVEI45NKoDJvS47
         RdZbg3yg+b3aiMa7KmFcq6Wqqg80AUnDYgTwklBqNJEjNcOPsjz5sp+FtJnuk0u+u/34
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rvo2EnbYZrSMFa4jx6EWs+htq6fmSf2FeAX42zd2/q8=;
        b=DfxW7Y0IjKIvBKVf9faOjZKPJQwpIp6y/QleXGMy7Sl8xBarubdEUAZKpZul9TtYIp
         xUl1eQlEZOuIqLO4UKq/NPNQL/rIyUrJ+XX9EU9n/ncn16Ar0PdVZl79uphfPUJdxKd+
         2qmx1ftQxUzdPRNoryhourWF0TZGlbAAIvbYDti4Nv3KCNSUWn44MGLmU/7yJ8x0BZu7
         fkfErJVORLX7fCslBpg1WW9qad+XHCzbRHS0Z1g4bYw0Jn2B9JJObTnjif/cHtu8U0y+
         glnAIwgatAMuPMcbs1CBpH20sCx+G5TE2d/mL2fge0GLdhkGir/C/GMycAVDSSxso/si
         68vg==
X-Gm-Message-State: ALoCoQnqSB6MZf5A6+zt3PsliQz2Ap3vIeykBUJ3qLD3ToxSpXPWNTQWxyXl0NCVB6cHgnsIa+KM
X-Received: by 10.112.157.100 with SMTP id wl4mr21112881lbb.108.1429050494331;
 Tue, 14 Apr 2015 15:28:14 -0700 (PDT)
Received: by 10.25.43.210 with HTTP; Tue, 14 Apr 2015 15:28:14 -0700 (PDT)
In-Reply-To: <xmqqzj6a1m3c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267170>

On Tue, Apr 14, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>>> diff --git a/cache.h b/cache.h
>>> index 3d3244b..7f9bab0 100644
>>> --- a/cache.h
>>> +++ b/cache.h
>>> @@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const
>>> char *suffix);
>>>  int daemon_avoid_alias(const char *path);
>>>  extern int is_ntfs_dotgit(const char *name);
>>>
>>> +/**
>>> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/%s".  If
>>> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
>>> + * "$HOME/.config/git/%s". Returns NULL if an error occurred.
>>> + */
>>> +extern char *xdg_config_home(const char *fn);
>>
>> Should this not be inserted close to home_config_paths()? Also, the
>> name "fn" sounds more like "function" than like "filename" to me,
>> especially keeping the name `config_fn_t` in mind. Maybe call the
>> parameter "filename" to avoid confusion?
>
> It is OK to omit the name in the extern declaration here.  We have
> to have a sensible variable name in the definition in path.c, of
> course ;-), and "filename" sounds like a very sensible suggestion.
>

It is OK, but I think this is bad practice.
Have a look at strbuf.h, there you'll find:

    extern int strbuf_getwholeline_fd(struct strbuf *, int, int);

It's not clear what the 2 ints are, probably a fd and a max size?
Even if guessed correctly, you'd still need another guess for the order.
