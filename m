From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo
 = bar"
Date: Tue, 07 Oct 2014 15:21:15 +0200
Message-ID: <5433E8CB.1050005@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003202743.GH16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 15:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbUhg-0001VA-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 15:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbaJGNVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 09:21:20 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:49682 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753236AbaJGNVT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 09:21:19 -0400
X-AuditID: 12074412-f792e6d000005517-52-5433e8cd2b87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.A2.21783.DC8E3345; Tue,  7 Oct 2014 09:21:17 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C4D.dip0.t-ipconnect.de [93.219.28.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s97DLFcg010438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Oct 2014 09:21:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141003202743.GH16293@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1D37wjjEYMt0FYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BlrNvSzFywQqXhyZz1jA+NO
	/i5GDg4JAROJf7PVuxg5gUwxiQv31rN1MXJxCAlcZpR4tn8tM4Rzlkni6aRNzCANvALaEntO
	6oE0sAioSlw/9IUJxGYT0JVY1NMMZosKBEh86HzACGLzCghKnJz5hAXEFhGIlzhzdBuYLSwQ
	InHg8wNWkJFCAv4S+5dXgoQ5BfQkTh/tAmtlFlCX+DPvEjOELS/RvHU28wRG/llIps5CUjYL
	SdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCHhKbSDcf1JuUOMAhyM
	Sjy8K7SMQ4RYE8uKK3MPMUpyMCmJ8m6/ABTiS8pPqcxILM6ILyrNSS0+xCjBwawkwnv6IlCO
	NyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCd/1zoEbBotT01Iq0zJwS
	hDQTByfIcC4pkeLUvJTUosTSkox4UDTGFwPjESTFA7S3FaSdt7ggMRcoCtF6ilFRSpyXGSQh
	AJLIKM2DGwtLOq8YxYG+FOadD1LFA0xYcN2vgAYzAQ1e1Q82uCQRISXVwDghW/nxiWiG22V+
	vyTtTGQcmY/eSdw0WdHi4WfzfesK39ec/n3T6oTN0vA0bymOBZ7LHV7Naf9YG3zv1R6PbP0p
	Na1Wlt3KDxiKBR8yPYhf/WrmnNAUFb7Yr/cT2esa+z7IyX97vMIp99eMFPv6g73T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257926>

On 10/03/2014 10:27 PM, Jeff King wrote:
> For small outputs, we sometimes use:
> 
>   test "$(some_cmd)" = "something we expect"
> 
> instead of a full test_cmp. The downside of this is that
> when it fails, there is no output at all from the script.
> Let's introduce a small helper to make tests easier to
> debug.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is in the same boat as the last commit; we can drop it without
> hurting the rest of the series.
> 
> Is test_eq too cutesy or obfuscated? I have often wanted it when
> debugging other tests, too. Our usual technique is to do:
> 
>   echo whatever >expect &&
>   do_something >actual &&
>   test_cmp expect actual
> 
> That's a bit verbose. We could hide it behind something like test_eq,
> too, but it introduces several extra new processes. And I know people on
> some fork-challenged platforms are very sensitive to the number of
> spawned processes in the test suite.

I don't like the three-argument version of test_eq. Wouldn't using a
comparison operator other than "=" would be very confusing, given that
"eq" is in the name of the function? It also doesn't look like you use
this feature.

If you want to write a helper that allows arbitrary comparator
operators, then I think it would be more readable to put the comparison
operator in the middle, like

    test_test foo = bar

And in fact once you've done that, couldn't we just make this a generic
wrapper for any `test` command?

test_test () {
	if ! test "$@"
	then
		echo >&2 "test failed: $*"
		false
	fi
}

Feel free to bikeshed the function name.

An alternative direction to go would be to specialize the function for
equality testing and delegate to test_cmp to get better output for
failures, but optimized to avoid excess process creation in the happy path:

test_eq () {
	if test "$1" != "$2"
	then
		printf "%s" "$1" >expect &&
		printf "%s" "$2" >actual &&
		test_cmp expect actual
	fi
}

(but using properly-created temporary file names).

Finally, if we want a function intended mainly for checking program
output (like the test_eql function suggested by Junio), it might be
simpler to use if it accepts the function output on its stdin:

	test_output () {
		echo "$1" >expect &&
                cat >actual &&
                test_cmp expect actual
	}
        ...
	do_something | test_output whatever

This would make it easier to generate the input using an arbitrary shell
pipeline.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
