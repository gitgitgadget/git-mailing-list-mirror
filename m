From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-file: consider core.crlf when writing merge
 markers
Date: Tue, 24 Nov 2015 09:21:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511240844380.1686@s15462909.onlinehome-server.info>
References: <1448314332-15581-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Tue Nov 24 09:22:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a18ra-00082B-3F
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 09:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbKXIWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 03:22:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:55606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbbKXIWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 03:22:01 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Ltr89-1aQxAO30Wz-011DBA;
 Tue, 24 Nov 2015 09:21:57 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1448314332-15581-1-git-send-email-dev+git@drbeat.li>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:9nq9oORz7Cv1KL5cgwPaoMAU+Y7LhBu1t3in7GgSKo5LwhyRcJ4
 ZGzPEbXl19sm31VcXGNc85zEbSYoYPNz0peCZjQ3S9bbkt9LP/H1deoKhDLX01vnR5OW/gg
 2ql2OtQU3jlYXvTpPOwlBMcZtI4aWNhpfnXbhSRz35+nVqZ/OqI/l8LaItrJRCELH0C2fRM
 kKZBDKcooZF3eYOH41Y/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+A3j11O8Czk=:sXYugeMxHUM+uIE02QOfLv
 Nz1M2hJE6d2cqFAdTBEsmh20RqMeXdsUBV9tyBB4IvOin6l36IY8qyOUjyAFTYS+glXGq4vKH
 mgt4bky30JoeJw1R7A2XCACcAeTjzmO+KnlP7tNBibC/qFy0TTjtJlBBMYhgTihPMQkS1m85p
 wbJ6DCr6gVl3Atu81AlynQpukWteuW8sSWqcSl5Hvo958cXjO+AIvIFg1RuKFnx+usgFg9b/1
 UcH/7RTih/z3QdcxRH937eM6CT060D7eJ2QYf5oic+7F3qU/ChRFQB8lVsFalqjKbf8nfbB6e
 GIDWw2Isr7F7L2mVcgGXDi92+M7tru2EpzxFzHPIO+yqjtXHZ/8SvOaAuLs/qScrODUCACzth
 ha+tpT7/eoW2wwDYeGcI7zwu9lM9VL1OJoTWgIMA7lvk5twVY0byd8EEvx0HIMx8wWjBM6MoK
 QRkncTeuDHYhwTNWpBnS1DgfZw2D2L4uVEhvEHasadgdixgjebV2J/WPcPNFjXx41zwkWSOO1
 HZVs8bOYyoplhdpW+6Y1CFebY64iGk719kNV1r3V8wAAnyfgBFPXtDJ5vw8TjwiZWQ5OUQIbm
 O/RVpqVASJbgkS/inx+M1Ohz1y4Ub2aCm5yNk5derIZC7NO0y9Nv9fPXkwWP4VS0QJGseauc0
 tQIITY8eDIoEZQ4nKNydCd/84xBRe6qLm6btEBabCeFLgWYmiVyKqZI4YBd/gMAxpJiXuhuxs
 P0FJynGdiHA0VX9lrMGJ1TLL9ARVL74N1gon4wDqT7yK3219GUX0oCvj5C+9/5z1tI0VFa5L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281612>

Hi Beat,

On Mon, 23 Nov 2015, Beat Bolli wrote:

> When merging files in repos with core.eol = crlf, git merge-file inserts
> just a LF at the end of the merge markers. Files with mixed line endings
> cause trouble in Windows editors and e.g. contrib/git-jump, where an
> unmerged file in a run of "git jump merge" is reported as simply "binary
> file matches".

Wow, what a beautiful contribution!

I wonder how difficult it would be to make this work with gitattributes,
i.e. when .gitattributes' `eol` setting disagrees with core.eol.

I imagine that we could use convert.c to do all the hard work, e.g. by
adding a function

	const char *eol_for_path(const char *path, const char *contents)
	{
		enum eol eol;
		struct conv_attrs ca;
		struct text_stat stats;

		convert_attrs(&ca, path);
		eol = output_eol(ca.crlf_action);
		if (eol != EOL_CRLF)
			eol = EOL_LF;
		else if (!*contents || (crlf_action != CRLF_AUTO &&
				crlf_action != CRLF_GUESS)
			eol = EOL_CRLF;
		else {
			ca.crlf_action = input_crlf_action(ca.crlf_action,
					ca.eol_attr);
			if (crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
				eol = core_eol;
			else if (stats.crlf)
				eol = EOL_CRLF;
			else
				eol = EOL_LF;
		}

		return eol == EOL_CRLF ? "\r\n" : "\n";
	}

Of course you could also make that function return `enum eol` instead of
`const char *`; that would probably make the changes to xdiff/xmerge.c
less invasive (and closer to what you have already).

Ciao,
Dscho
